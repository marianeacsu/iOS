import Foundation
import UIKit

class UserViewController: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        return label
    }()
    private lazy var userView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    // MARK: - LyfeCycle
    
    init(user: AppUser) {
        super.init(nibName: nil, bundle: nil)

        self.nameLabel.text = user.name
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setConstraints()
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(userView)
        userView.addSubview(nameLabel)
    }
    
    private func setConstraints() {
        userView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        userView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        userView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        userView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: userView.topAnchor, constant: 90.0).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: userView.centerXAnchor).isActive = true
    }
}
