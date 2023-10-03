//
//  ScreenShotDetailTabBarViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import Foundation


protocol ScreenShotDetailTabBarViewModelInput: AnyObject {
    var viewController: ScreenShotDetailTabBarViewModelOutput? { get set }
    func deleteCurrentScreenshot()
}

protocol ScreenShotDetailTabBarViewModelOutput: AnyObject {

}

final class ScreenShotDetailTabBarViewModel {

    private let screenshots: NSMutableArray
    private var selectedIndex: Int
    private var viewControllers: [ScreenshotDetailsViewController]
    weak var viewController: ScreenShotDetailTabBarViewModelOutput?
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
        viewControllers = screenshots.compactMap { screenShot in
            if let screenShot = screenShot as? ScreenshotModel {
                let viewModel = ScreenshotDetailsViewModel(screenshot: screenShot)
                return ScreenshotDetailsViewController(viewModel: viewModel)
            } else {
                return nil
            }
        }
    }
}


extension ScreenShotDetailTabBarViewModel: ScreenShotDetailTabBarViewModelInput {

    func deleteCurrentScreenshot() {
        screenshots.removeObject(at: selectedIndex)
        viewControllers.remove(at: selectedIndex)
        if viewControllers.isEmpty {
            selectedIndex = -1
        } else if selectedIndex == viewControllers.count {
            selectedIndex = viewControllers.count - 1
        }
        galleryViewController?.reloadPage()
    }
}

extension ScreenShotDetailTabBarViewModel: ScreenshotInfoViewControllerInput {

    func getScreenshotNote() -> String? {
        currentScreenshot?.note
    }

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

    func update(screenshotNote: String?) {
        guard let currentScreenshot = currentScreenshot else {
            return
        }
        currentScreenshot.note = screenshotNote
    }

}

extension ScreenShotDetailTabBarViewModel: ScreenShotsGalleryViewControllerInput {

    func getScreenShots() -> NSArray {
        return screenshots
    }

    func getCurrentSelectedIndex() -> Int {
        return selectedIndex
    }

    func set(currentSelectedIndex: Int) {
        selectedIndex = currentSelectedIndex
    }

    func getCurrentViewController() -> ScreenshotDetailsViewController? {
        if selectedIndex >= 0, selectedIndex < viewControllers.count {
            return viewControllers[selectedIndex]
        }
        return nil
    }

    func getScreenshotDetailsViewControllers() -> [ScreenshotDetailsViewController] {
        return viewControllers
    }
}
