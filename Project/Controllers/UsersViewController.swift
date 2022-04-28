import UIKit
import SwiftUI

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var users = [AppUser]()
    private let coreDataManager: UserServiceManager = CoreDataManager()
    private let cellReuseIdentifier = "cell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        populateUsersList()
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserViewController(user: handleGetUserId(indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, isComplete in
            isComplete(true)
            
            self.handleDeleteAction(indexPath.row)
            self.navigationController?.popViewController(animated: true)
        }
        
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, isComplete in
            isComplete(true)
            
            self.handleEditAction(indexPath.row)
            self.navigationController?.popViewController(animated: true)
        }
        
        editAction.backgroundColor = .gray

        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    // MARK: - CoreData
    
    private func populateUsersList() {
        users = coreDataManager.getAllUsers()
    }
    
    private func handleDeleteAction(_ index: Int) {
        let users = coreDataManager.getAllUsers()
        
        let user = users[index]
        
        coreDataManager.delete(employe: user)
    }
    
    private func handleEditAction(_ index: Int) {
        let users = coreDataManager.getAllUsers()
        
        let user = users[index]
        
        coreDataManager.edit(id: user.id)
    }
    
    private func handleGetUserId(_ index: Int) -> AppUser {
        let users = coreDataManager.getAllUsers()
        
        let user = users[index]
        
        return coreDataManager.getUserById(employe: user) ?? AppUser(id: "", email: "", name: "", password: "")
    }
}

