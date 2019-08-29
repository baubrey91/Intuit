import UIKit

class HomeViewController: UIViewController {
    
    fileprivate var intuitClient = IntuitClient()
    
    @IBOutlet weak var tableView: UITableView!
    
    var repos = [Repo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        intuitClient.getIntuitRepo(completion: { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let repos):
                weakSelf.repos = repos
                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Remove force unwrap
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
        
        cell.nameLabel.text = repos[indexPath.row].name
        return cell
    }
}

