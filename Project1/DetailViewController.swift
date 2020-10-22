import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageCount: Int?
    var totalImageCount: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo \(selectedImageCount ?? 0) of \(totalImageCount ?? 0)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            print(imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    // each ViewController that inherits from UIViewController needs to be told what to do when it appears and when it disappears, there are additional options here but this is good enough for now. 
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image Found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage ?? "no image name"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // makes this work on iPad
        
        present(vc, animated: true)
    }
}
