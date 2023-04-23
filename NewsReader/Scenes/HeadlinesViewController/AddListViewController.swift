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
    
    private lazy var dataSource = RxTableViewSectionedAnimatedDataSource<AddsSection> { ds, tv, ip, item in
        
        switch item {
        case .activityIndicator:
            let cell = tv.dequeueReusableCell(withIdentifier: ActivityIndicatorCell.id) as! ActivityIndicatorCell
            cell.startAnimating()
            return cell
        case .ad(let ad):
            let cell = tv.dequeueReusableCell(withIdentifier: HEADLINE_CELL) as! AdsListCell
            cell.configureCell(with: ad)
            return cell
        }
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
        tableView.register(ActivityIndicatorCell.self , forCellReuseIdentifier: ActivityIndicatorCell.id)
        
        tableView.rx
            .itemSelected
            .subscribe { [unowned self] ip in
                tableView.deselectRow(at: ip, animated: true)
            }
            .disposed(by: disposeBag)

        tableView.rx
            .contentOffset
            .map(\.y)
            .filter { [unowned self] y in
                let heihgt = tableView.frame.size.height
                let distanceFormBotton = tableView.contentSize.height - y
                return distanceFormBotton < heihgt
            }
            .throttle(.seconds(3), latest: true, scheduler: MainScheduler.instance)
            .map{ _ in }
            .bind(to: viewModel.nextPageLoadingTrigger)
            .disposed(by: disposeBag)


        viewModel
            .addList
            .drive(
                tableView.rx.items(dataSource: dataSource)
            )
            .disposed(by: disposeBag)
    }
}
