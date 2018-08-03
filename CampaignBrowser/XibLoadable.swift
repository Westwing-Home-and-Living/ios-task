//
//  XibLoadable.swift
//  CampaignBrowser
//
//  Created by Adrian Truszczynski on 03.08.2018.
//  Copyright © 2018 Westwing GmbH. All rights reserved.
//

import UIKit

protocol XibLoadable where Self: UIView {
}

extension XibLoadable {
    
    func addXib() {

        guard let views = Bundle(for: Self.self).loadNibNamed(String(describing: Self.self), owner: self) as? [UIView],
            let view = views.first else { return }

        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false

        let contraints = [
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(contraints)
    }
}
