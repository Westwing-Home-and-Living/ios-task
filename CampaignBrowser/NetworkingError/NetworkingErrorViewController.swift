//
//  NetworkingErrorViewController.swift
//  CampaignBrowser
//
//  Created by Kamil Maciejczyk on 09.08.2018.
//  Copyright © 2018 Westwing GmbH. All rights reserved.
//

import UIKit

/// VC for error view for use with views which can have problem with internet connection
class NetworkingErrorViewController: UIViewController, StoryboardConstructing {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    //MARK: - Public methods
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSubviews()
    }
    
    //MARK: - Private methods
    
    private func prepareSubviews() {
        infoLabel.text = NSLocalizedString("NetworkingErrorViewController_infoLabelTitle", comment: "")
        retryButton.setTitle(NSLocalizedString("NetworkingErrorViewController_retryButtonTitle", comment: ""), for: .normal)
    }
}
