//
//  ScreenshotInfoViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import Foundation


protocol ScreenshotInfoViewModelInput: AnyObject {
    var viewController: ScreenshotInfoViewModelOutput? { get set }
}

protocol ScreenshotInfoViewModelOutput: AnyObject {

}

final class ScreenshotInfoViewModel {

    weak var viewController: ScreenshotInfoViewModelOutput?

    init() {

    }
}


extension ScreenshotInfoViewModel: ScreenshotInfoViewModelInput {

}
