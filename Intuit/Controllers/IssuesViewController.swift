import UIKit

class IssuesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let intuitClient = IntuitClient()
    let viewModel = IssuesViewModel()
    var repoName: String
    
    init(repoName: String) {
        self.repoName = repoName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: IssueCell.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: IssueCell.cellIdentifier)
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getIssues(for: repoName)
    }
    
    //Gesture Recognizers
    
    @IBAction func swipeToDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // We only want the tap recognizer to be in the grey area
    @IBAction func tapToDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension IssuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueCell.cellIdentifier) as? IssueCell else {
            return IssueCell()
        }
        cell.configureCell(withTitle: viewModel.issues[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = viewModel.issues[indexPath.row]
        let issuesViewController = IssueDetailViewController(details: issue.body)
        let navigationController = UINavigationController(rootViewController: issuesViewController)
        self.present(navigationController, animated: true)
    }
}

extension IssuesViewController: IssuesViewModelDelegate {
    func loadTableView() {
        self.tableView.reloadData()
    }
    
    func showError(error: Error) {
        
        let retryAlert = UIAlertController.makeRetry(errorDescription: error.localizedDescription,
                                                     retryCompletion: { [weak self] _ in
                                                        guard let weakSelf = self else { return }
                                                        weakSelf.viewModel.getIssues(for: weakSelf.repoName)
        })
        self.present(retryAlert, animated: true)
    }
}
