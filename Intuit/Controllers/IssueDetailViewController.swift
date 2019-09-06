import UIKit

class IssueDetailViewController: UIViewController {
    
    enum Constants {
        static let dismiss = "Dismiss".localized()
    }
    
    @IBOutlet weak var issueDetailTextView: UITextView!
    
    let details: String!
    
    init(details: String) {
        self.details = details
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.dismiss,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(closeAction))
        self.issueDetailTextView.text = details
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true)
    }
}
