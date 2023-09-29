//
//  ScreenshotsViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 29/09/23.
//

import UIKit

protocol ScreenshotsViewModelInput: AnyObject {
    var viewController: ScreenshotsViewModelOutput? { get set }
}

protocol ScreenshotsViewModelOutput: AnyObject {

}

final class ScreenshotsViewModel {

    weak var viewController: ScreenshotsViewModelOutput?

    init() {

    }

}

extension ScreenshotsViewModel: ScreenshotsViewModelInput {
    
}
