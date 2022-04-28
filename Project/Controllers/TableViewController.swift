import UIKit
import SwiftUI

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var repositories = [Repository]()
    private let gitManager = GitAPIManager()
    private let cellReuseIdentifier = "cell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        populateRepositories(query: "iOS")
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = repositories[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController(repositoryName: repositories[indexPath.row].fullName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Networking
    
    private func populateRepositories(query: String) {
        gitManager.searchRepositories(query: query) { [weak self] repositories in
            self?.repositories = repositories
            self?.tableView.reloadData()
        }
    }
}

