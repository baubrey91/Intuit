import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var searchBar = UISearchBar()
    let viewModel = HomeViewModel()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        navigationItem.titleView = searchBar
        searchBar.delegate = viewModel.self
    }
    
    //Network call needs to be made on didAppear to not hold up loading the UI
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getRepos()
    }
}

// MARK: - Table View

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.cellIdentifier, for: indexPath) as? RepoCell else { return RepoCell() }
        let repo = viewModel.filteredRepos[indexPath.row]
        cell.configureCell(withRepo: repo)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.filteredRepos[indexPath.row]
        let detailViewController = DetailViewController(repo: repo)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func loadTableView() {
        self.tableView.reloadData()
    }
    
    func showError(error: Error) {

        let retryAlert = UIAlertController.makeRetry(errorDescription: error.localizedDescription,
                                                     retryCompletion: { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.getRepos()
        })
        self.present(retryAlert, animated: true)
    }
}
