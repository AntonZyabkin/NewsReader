import UIKit

final class AdsListCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    func configureCell(with: Ad) {
        titleLabel.text = with.title
        categoryLabel.text = with.category?.title
        descriptionLabel.text = with.description
    }
}
