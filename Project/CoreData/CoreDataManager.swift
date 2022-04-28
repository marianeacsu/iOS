import Foundation
import CoreData
import UIKit

protocol UserServiceManager {
    func save(employe: AppUser)
    func getAllUsers() -> [AppUser]
    func getUserById(employe: AppUser) -> AppUser?
    func edit(id: String)
    func delete(employe: AppUser)
}

class CoreDataManager: UserServiceManager {
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Project")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
    
    func save(employe: AppUser) {
        
        let _ = self.toUser(employe: employe)
        
        self.save()
    }
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllUsers() -> [AppUser] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            var employees: [AppUser] = []
            let users = try viewContext.fetch(request)
            for user in users {
                employees.append(self.toAppUser(user: user))
            }
            
            return employees
        } catch {
            return []
        }
    }
    
    func getUserById(employe: AppUser) -> AppUser? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try viewContext.fetch(request)
            for user in users {
                if self.toAppUser(user: user).id == employe.id {
                    return toAppUser(user: user)
                }
            }
            
            return nil
        } catch {
            return nil
        }
    }
    
    func edit(id: String) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        var userToBeEdited = User()
        do {
            let users = try viewContext.fetch(request)
            for user in users {
                if self.toAppUser(user: user).id == id {
                    userToBeEdited = user
                }
            }
        } catch { }
        
        userToBeEdited.name = "Changed"
        save()
    }
    
    func delete(employe: AppUser) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        var userToBeDeleted = NSManagedObject()
        do {
            let users = try viewContext.fetch(request)
            for user in users {
                if self.toAppUser(user: user).id == employe.id {
                    userToBeDeleted = user
                }
            }
        } catch { }
        
        viewContext.delete(userToBeDeleted)
        save()
    }
    
    // MARK: - Private
    
    private func toAppUser(user: User) -> AppUser {
        return AppUser(id: user.id ?? "", email: user.email ?? "", name: user.name ?? "", password: user.password ?? "")
    }
    
    private func toUser(employe: AppUser) -> User {
        let user = User(context: viewContext)
        user.id = employe.id
        user.email = employe.email
        user.name = employe.name
        user.password = employe.password
        
        return user
    }
}
