//
//  CampaignListingRetryView.swift
//  CampaignBrowser
//
//  Created by Adrian Truszczynski on 03.08.2018.
//  Copyright © 2018 Westwing GmbH. All rights reserved.
//

import UIKit

@IBDesignable
final class CampaignListingRetryView: UIView, XibLoadable {
    
    // MARK: - Outlets
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setups
    
    private func setup() {
        addXib()
        localize()
    }
    
    private func localize() {
        infoLabel.text = NSLocalizedString("campaignListing.retry.labels.info", comment: "")
        button.setTitle(NSLocalizedString("campaignListing.retry.buttons.retry", comment: ""), for: .normal)
    }
}
