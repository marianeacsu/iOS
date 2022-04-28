import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usersButton: UIButton!
    
    private var coreDataManager: UserServiceManager = CoreDataManager()
    
    // MARK: - LyfeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Private
    
    @IBAction func onRegister(_ sender: Any) {
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            coreDataManager.save(employe: AppUser(id: UUID().uuidString, email: email, name: name, password: password))
        }
    }
}
