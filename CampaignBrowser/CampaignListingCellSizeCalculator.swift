import UIKit

/**
 Calculator used to determine the size of dynamic `CampaignCell`
 */
class CampaignListingCellSizeCalculator {
    func size(
        for campaign: CampaignListingView.Campaign,
        _ collectionView: UICollectionView
    ) -> CGSize {
        
        let width = collectionView.frame.width
        
        let imageHeight = collectionView.frame.width / style.campaignCell.imageViewAspectRatio
        
        let labelWidth = width - style.campaignCell.labelHorizontalPadding * 2
        
        let titleHeight: CGFloat = campaign.name.height(
            withConstrainedWidth: labelWidth,
            font: style.font.title
        )
        
        let descriptionHeight: CGFloat = campaign.description.height(
            withConstrainedWidth: labelWidth,
            font: style.font.subtitle
        )
        
        let height = imageHeight
            + titleHeight
            + style.campaignCell.labelInterlinePadding
            + descriptionHeight
        
        return CGSize(
            width: width,
            height: height
        )
    }
}
