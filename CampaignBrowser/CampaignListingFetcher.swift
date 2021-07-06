import RxSwift

/**
Responsible for fetching campaign listings.
*/
protocol CampaignListingFetcher {
    func fetchCampaigns() -> Observable<CampaignList>
}

/**
Live implementation of the `CampaignListingFetcher`.
*/
class CampaignListingFetcherLive: CampaignListingFetcher {
    func fetchCampaigns() -> Observable<CampaignList> {
        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
    }
}
