@testable import CampaignBrowser
import XCTest
import SnapshotTesting

class CampaignBrowserTests: XCTestCase {
    
    private var view: CampaignListingViewController!
    
    private var fetcher: CampaignFetcherMock {
        ServiceLocator.instance.campaignFetcher as! CampaignFetcherMock
    }
    
    override func setUp() {
        ServiceLocator.instance.campaignFetcher = CampaignFetcherMock()
        view = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as CampaignListingViewController?
    }
    
    func test_snapshot() {
        fetcher.testData = .normal
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneXsMax))
    }
    
    func test_snapshot_longTitleHas2Lines() {
        fetcher.testData = .longText
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneXsMax))
    }
    
    func test_snapshot_shortText() {
        fetcher.testData = .shortText
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneXsMax))
    }
}
