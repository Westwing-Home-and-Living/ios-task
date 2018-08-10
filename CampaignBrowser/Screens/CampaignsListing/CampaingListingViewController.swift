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
    
    private var errorViewController:NetworkingErrorViewController!
    
    //MARK: - Public methods
    //MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(typedView != nil)
        configureErrorView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadData()
    }
    
    //MARK: - Private methods
    
    private func configureErrorView(){
        
        guard let viewController = NetworkingErrorViewController.storyboardInstance() else { return }
        errorViewController = viewController
        errorViewController.loadViewIfNeeded()
        errorViewController.retryButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.errorViewController.dismiss(animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
    }
    
    private func downloadData(){
        
        // Load the campaign list and display it as soon as it is available.
        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:
                { [weak self] campaigns in
                    self?.typedView.display(campaigns: campaigns)
                },
                       onError:
                { [weak self] _ in
                    self?.navigateToErrorView()
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func navigateToErrorView() {
        show(errorViewController, sender: self)
    }
}
