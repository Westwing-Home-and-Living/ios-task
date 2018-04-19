import UIKit
import RxSwift


/**
 The view controller responsible for listing all the campaigns. The corresponding view is the `CampaignListingView` and
 is configured in the storyboard (Main.storyboard).
 */
class CampaignListingViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet
    private(set) weak var typedView: CampaignListingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(typedView != nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load the campaign list and display it as soon as it is available.
        fetchCampaignList()
        
    }
    func fetchCampaignList() {

        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] campaigns in
                    self?.typedView.display(campaigns: campaigns)
                },
                onError: {[weak self] error in

                    let alert = UIAlertController(title: Constants.Alerts.errorTitle, message: Constants.Errors.connectionIssue, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: Constants.Alerts.retryBtn, style: UIAlertActionStyle.default, handler: { [weak self] alert in
                        self?.fetchCampaignList()
                    }))
                    self?.present(alert, animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)


    }
}
