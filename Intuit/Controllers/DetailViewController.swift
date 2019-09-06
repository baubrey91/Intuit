import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var issuesButton: UIButton!
    
    let repo: Repo
    
    init(repo: Repo) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.starsLabel.text = repo.formattedStars
        self.watchersLabel.text = repo.formattedWatchers
        self.issuesButton.setTitle(repo.formattedIssues, for: .normal)
        self.forksLabel.text = repo.formattedForks
        self.createdLabel.text = repo.formattedCreatedDate
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        let issuesViewController = IssuesViewController(repoName: repo.name)
        issuesViewController.modalPresentationStyle = .overFullScreen
        self.present(issuesViewController, animated: true)
    }
}
