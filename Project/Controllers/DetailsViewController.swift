import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    private lazy var repositoryLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        return label
    }()
    private lazy var repositoryView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    private lazy var readMe: UILabel = {
       let label = UILabel()
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    let scrollView: UIScrollView = {
            let v = UIScrollView()
            return v
        }()
        
    private let gitManager = GitAPIManager()
    
    // MARK: - LyfeCycle
    
    init(repositoryName: String) {
        super.init(nibName: nil, bundle: nil)

        self.repositoryLabel.text = repositoryName
        getReadme(fullName: repositoryName)
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
        view.addSubview(repositoryView)
        repositoryView.addSubview(repositoryLabel)
        repositoryView.addSubview(scrollView)
        scrollView.addSubview(readMe)
    }
    
    private func setConstraints() {
        repositoryView.translatesAutoresizingMaskIntoConstraints = false
        repositoryLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        readMe.translatesAutoresizingMaskIntoConstraints = false
        
        repositoryView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        repositoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        repositoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        repositoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        repositoryLabel.topAnchor.constraint(equalTo: repositoryView.topAnchor, constant: 90.0).isActive = true
        repositoryLabel.centerXAnchor.constraint(equalTo: repositoryView.centerXAnchor).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: repositoryLabel.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: repositoryView.bottomAnchor, constant: -80.0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: repositoryView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: repositoryView.trailingAnchor).isActive = true
        
        readMe.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        readMe.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        readMe.leadingAnchor.constraint(equalTo: repositoryView.leadingAnchor).isActive = true
        readMe.trailingAnchor.constraint(equalTo: repositoryView.trailingAnchor).isActive = true
    }
    
    private func getReadme(fullName: String) {
        gitManager.getReadmeFrom(fullname: fullName) { [weak self] readme in
            print(readme)
            self?.readMe.text = readme
        }
    }
}
