import Foundation


class ServiceLocator {
    static let instance: ServiceLocator = ServiceLocator()

    lazy var imageService: ImageService = ImageService()

    lazy var networkingService: NetworkingService = NetworkingServiceLive(urlSession: URLSession.shared)
    
    lazy var campaignFetcher: CampaignListingFetcher = CampaignListingFetcherLive()
}
