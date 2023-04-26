import UIKit
import Nuke
import NukeUI
final class AdsListCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: LazyImageView!

    
    func configure(with viewModel: AdsListItemViewModel) {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        dateLabel.text = viewModel.date
        locationLabel.text = viewModel.location
        imageView.url = viewModel.imageURL
    }
}
