//
//  ScreenShotDetailTabBarViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import Foundation


protocol ScreenShotDetailTabBarViewModelInput: AnyObject {
    var viewController: ScreenShotDetailTabBarViewModelOutput? { get set }
}

protocol ScreenShotDetailTabBarViewModelOutput: AnyObject {

}

final class ScreenShotDetailTabBarViewModel {

    private let screenshots: NSMutableArray
    private var selectedIndex: Int
    weak var viewController: ScreenShotDetailTabBarViewModelOutput?
    weak var screenshotInfoViewController: ScreenshotInfoViewControllerOutput?
    weak var galleryViewController: ScreenShotsGalleryViewControllerOutput?

    var currentScreenshot: ScreenshotModel? {
        guard selectedIndex >= 0, selectedIndex < screenshots.count, screenshots.count != 0 else {
            return nil
        }
        return screenshots[selectedIndex] as? ScreenshotModel
    }

    init(screenshots: NSMutableArray, selectedIndex: Int) {
        self.screenshots = screenshots
        self.selectedIndex = selectedIndex
    }
}


extension ScreenShotDetailTabBarViewModel: ScreenShotDetailTabBarViewModelInput {

}

extension ScreenShotDetailTabBarViewModel: ScreenshotInfoViewControllerInput {

    func getCreationDateString() -> String? {
        guard let currentScreenshot = currentScreenshot,
              let date = currentScreenshot.creationDate else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy hh:mm a"
        return dateFormatter.string(from: date)
    }

    func getName() -> String? {
        currentScreenshot?.name
    }

    func getSizeInfo() -> String? {
        guard let currentScreenshot = currentScreenshot else {
            return nil
        }
        var sizeString: String = ""
        if let imageSize = currentScreenshot.imageSize {
            sizeString = String(format: "%.2f | ", imageSize)
        }
        return sizeString + "\(currentScreenshot.pixelWidth) x \(currentScreenshot.pixelHeight)"
    }

    func getPredictionText() -> String? {
        currentScreenshot?.predictionOutput
    }

}

extension ScreenShotDetailTabBarViewModel: ScreenShotsGalleryViewControllerInput {

}
