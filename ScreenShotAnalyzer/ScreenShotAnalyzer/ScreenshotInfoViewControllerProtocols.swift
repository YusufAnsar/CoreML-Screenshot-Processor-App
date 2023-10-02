//
//  ScreenshotInfoViewControllerProtocols.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import Foundation


protocol ScreenshotInfoViewControllerInput: AnyObject {
    func getScreenshotNote() -> String?
    func getCreationDateString() -> String?
    func getName() -> String?
    func getSizeInfo() -> String?
    func getPredictionText() -> String?
    func update(screenshotNote: String?)
}
