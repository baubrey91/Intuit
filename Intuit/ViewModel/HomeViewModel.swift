import UIKit

protocol HomeViewModelDelegate: NSObjectProtocol {
    func loadTableView()
    func showError(error: Error)
}

class HomeViewModel: NSObject {
    
    private let intuitClient = IntuitClient()
    weak var delegate: HomeViewModelDelegate?
    var repos = [Repo]()
    var filteredRepos = [Repo]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.loadTableView()
            }
        }
    }
    
    func getRepos() {
        intuitClient.getIntuitRepo(completion: { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let repos):
                weakSelf.filteredRepos = repos
                weakSelf.repos = repos
            case .failure(let error):
                weakSelf.delegate?.showError(error: error)
            }
        })
    }
}

extension HomeViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRepos = searchText.isEmptyOrWhiteSpace ? repos : repos.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
}
