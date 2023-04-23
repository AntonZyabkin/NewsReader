import UIKit
import RxSwift
import RxCocoa
import RxDataSources

private let HEADLINE_CELL = "AdsListCell"

final class AddListViewController: UIViewController {
    
    
    typealias ViewModel = AddListViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: ViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var dataSourse = RxTableViewSectionedAnimatedDataSource<AddsSection> { (ds, tv, ip, item) in
        let cell = tv.dequeueReusableCell(withIdentifier: HEADLINE_CELL) as! AdsListCell
        cell.configureCell(with: item)
        return cell
    }
            
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confifureViews()
    }
}


private extension AddListViewController {
    func confifureViews() {
        confifureTableViews()
    }

    func confifureTableViews() {
        let nib = UINib(nibName: "AdsListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HEADLINE_CELL)
        
        
        tableView.rx.itemSelected
            .subscribe { [unowned self] ip in
                tableView.deselectRow(at: ip, animated: true)
            }
            .disposed(by: disposeBag)




        viewModel
            .addList
            .drive(
                tableView.rx.items(dataSource: dataSourse)
            )
            .disposed(by: disposeBag)
    }
}
