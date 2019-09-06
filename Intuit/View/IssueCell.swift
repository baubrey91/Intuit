import UIKit

class IssueCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    static let cellIdentifier = "IssueCell"
    
    func configureCell(withTitle title: String) {
        self.titleLabel.text = title
    }
}
