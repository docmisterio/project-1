import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            let orderedItems = items.sorted()
            for item in orderedItems {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
        // every tableView needs to know how many rows to show.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
        // every tableView needs to know what text to show for each cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
            vc.selectedImageCount = indexPath.row + 1
            vc.totalImageCount = pictures.count
            // on click each cell needs to know what to do WHEN it's clicked.
        }
    }
    
    @objc func recommendTapped() {
        let shareText = "check out my app that I'm building with #100DaysOfSwift"
        
        let recommendViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        recommendViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(recommendViewController, animated: true)
    }
}
