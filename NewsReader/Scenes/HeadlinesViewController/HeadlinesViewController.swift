import UIKit
import RxSwift
import RxCocoa

final class HeadlinesViewController: UIViewController {
    
    
    typealias ViewModel = HeadlinesViewModel
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
