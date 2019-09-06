import Foundation
import UIKit

class RepoCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: AvatarImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let cellIdentifier = "RepoCell"
    
    func configureCell(withRepo repo: Repo) {
        self.avatarImage.imageFromServerURL(with: repo.owner.avatarImage)
        self.nameLabel.text = repo.name
        self.descriptionLabel.text = repo.description
    }
}
