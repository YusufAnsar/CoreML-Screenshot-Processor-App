//
//  UIViewController+Helper.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 29/09/23.
//

import UIKit

extension UIViewController {

    static func loadFromNib() -> Self {
        
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
