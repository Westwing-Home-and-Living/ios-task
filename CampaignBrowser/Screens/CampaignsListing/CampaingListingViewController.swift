import UIKit
import RxSwift
import RxCocoa

/**
 The view controller responsible for listing all the campaigns. The corresponding view is the `CampaignListingView` and
 is configured in the storyboard (Main.storyboard).
 */
class CampaignListingViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet
    private(set) weak var typedView: CampaignListingView!
    @IBOutlet private var retryView: CampaignListingRetryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(typedView != nil)
        
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchData()
    }
    
    // MARK: - Setups
    
    private func setupBindings() {
        
        retryView.button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.hideRetryView()
                self?.fetchData()
            })
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Actions
    
    private func fetchData() {
        
        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] campaigns in
                self?.typedView.display(campaigns: campaigns)
                }, onError: { [weak self] _ in
                    self?.showRetryView()
            })
            .addDisposableTo(disposeBag)
    }
    
    private func showRetryView() {
        
        UIView.animate(withDuration: 0.3) {
            self.retryView.alpha = 1.0
        }
    }
    
    private func hideRetryView() {
        UIView.animate(withDuration: 0.3) {
            self.retryView.alpha = 0.0
        }
    }
}
