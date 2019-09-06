import UIKit

//This is the exact same as our other protocol but Issues needs it's own incase we need to add more later
protocol IssuesViewModelDelegate: NSObjectProtocol {
    func loadTableView()
    func showError(error: Error)
}

class IssuesViewModel: NSObject {
    
    private let intuitClient = IntuitClient()
    weak var delegate: IssuesViewModelDelegate?
    
    var issues = [Issue]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.loadTableView()
            }
        }
    }
    
    func getIssues(for repoName: String) {
        intuitClient.getIssues(for: repoName, completion: { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let issues):
                weakSelf.issues = issues
            case .failure(let error):
                print(error)
            }
        })
    }
}
