//
//  UIViewController_Ext.swift
//  CampaignBrowser
//
//  Created by Kamil Maciejczyk on 09.08.2018.
//  Copyright © 2018 Westwing GmbH. All rights reserved.
//

import Foundation
import UIKit

/// Extensions for comfortable constructing vc for storyboard
protocol StoryboardConstructing where Self:UIViewController{
}

extension StoryboardConstructing{
    
    /// Important! Storyboard name must be the same as VC name.
    static func storyboardInstance() -> Self? {
        let storyboard = UIStoryboard(name: String(describing: self),
                                      bundle: nil)
        
        return storyboard.instantiateInitialViewController() as? Self
    }
}
