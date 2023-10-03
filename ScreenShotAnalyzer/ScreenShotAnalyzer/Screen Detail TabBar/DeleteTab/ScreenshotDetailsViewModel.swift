//
//  ScreenshotDetailsViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 03/10/23.
//

import UIKit

protocol ScreenshotDetailsViewModelInput: AnyObject {
    var viewController: ScreenshotDetailsViewModelOutput? { get set }
    func getScreenshotImage() -> UIImage
    func getScreenshotNote() -> String?
    func getCreationDateString() -> String?
    func getName() -> String?
    func getSizeInfo() -> String?
    func getPredictionText() -> String?
    func update(screenshotNote: String?)
}

protocol ScreenshotDetailsViewModelOutput: AnyObject {

}

final class ScreenshotDetailsViewModel {

    weak var viewController: ScreenshotDetailsViewModelOutput?
    private let screenshot: ScreenshotModel

    init(screenshot: ScreenshotModel) {
        self.screenshot = screenshot
    }
}

extension ScreenshotDetailsViewModel: ScreenshotDetailsViewModelInput {

    func getScreenshotImage() -> UIImage {
        screenshot.image
    }

    func getScreenshotNote() -> String? {
        screenshot.note
    }

    func getCreationDateString() -> String? {
        guard let date = screenshot.creationDate else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy hh:mm a"
        return dateFormatter.string(from: date)
    }

    func getName() -> String? {
        screenshot.name
    }

    func getSizeInfo() -> String? {
        var sizeString: String = ""
        if let imageSize = screenshot.imageSize {
            sizeString = String(format: "%.2f | ", imageSize)
        }
        return sizeString + "\(screenshot.pixelWidth) x \(screenshot.pixelHeight)"
    }

    func getPredictionText() -> String? {
        screenshot.predictionOutput
    }

    func update(screenshotNote: String?) {
        screenshot.note = screenshotNote
    }
}
