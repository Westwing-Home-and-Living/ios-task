@testable import CampaignBrowser
import RxSwift

enum CampaignTestData: String {
    case normal = "campaigns"
    case longText = "campaigns_long_text"
    case shortText = "campaigns_short_text"
    
    private func list(from file: String) -> CampaignList {
        let bundle = Bundle(for: CampaignFetcherMock.self)
        let path = bundle.path(forResource: file, ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(CampaignList.self, from: data)
    }
    
    var campaignList: CampaignList {
        list(from: self.rawValue)
    }
}

class CampaignFetcherMock: CampaignListingFetcher {
    
    var testData: CampaignTestData!
    
    func fetchCampaigns() -> Observable<CampaignList> {
        Single<CampaignList>.create { [unowned self] observer in
            
            observer(.success(testData.campaignList))
            
            return Disposables.create()
        }.asObservable()
    }
}
