//
//  ScreenshotsViewModelCoordinatorDelegate.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 01/10/23.
//

import UIKit

protocol ScreenshotsViewModelCoordinatorDelegate: AnyObject {
    func screenshotsViewModel(_ viewModel: ScreenshotsViewModel, didSelectImageAtIndex index: Int)
}
