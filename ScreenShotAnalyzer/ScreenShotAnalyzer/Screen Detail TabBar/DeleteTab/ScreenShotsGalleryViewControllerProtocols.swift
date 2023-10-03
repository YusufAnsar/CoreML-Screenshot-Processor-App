//
//  ScreenShotsGalleryViewControllerProtocols.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 01/10/23.
//

import Foundation

protocol ScreenShotsGalleryViewControllerInput: AnyObject {
    var galleryViewController: ScreenShotsGalleryViewControllerOutput? { get set }
    func getScreenShots() -> NSArray
    func getCurrentSelectedIndex() -> Int
    func set(currentSelectedIndex: Int)
    func getCurrentViewController() -> ScreenshotDetailsViewController?
    func getScreenshotDetailsViewControllers() -> [ScreenshotDetailsViewController]
}

protocol ScreenShotsGalleryViewControllerOutput: AnyObject {
    func reloadPage()
}
