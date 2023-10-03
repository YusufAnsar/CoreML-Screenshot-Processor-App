//
//  UIView+AutoLayoutHelpers.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 03/10/23.
//

import UIKit

extension UIView {

    func addConstaintsToSuperview(viewPadding: UIEdgeInsets = .zero) {
        guard superview != nil else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: superview!.topAnchor,
                             constant: viewPadding.top).isActive = true
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor,
                                 constant: viewPadding.left).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor,
                                 constant: -(viewPadding.right)).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor,
                                 constant: -(viewPadding.bottom)).isActive = true
    }
}
