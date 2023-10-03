//
//  UIViewController+Helper.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 03/10/23.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController, onContentView contentView: UIView? = nil) {
        addChild(child)
        let superView: UIView = contentView ?? self.view
        superView.addSubview(child.view)
        child.view.addConstaintsToSuperview()
        child.didMove(toParent: self)
    }
}
