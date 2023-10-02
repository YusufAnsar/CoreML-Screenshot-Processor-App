//
//  ScreenshotInfoViewControllerProtocols.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import Foundation


protocol ScreenshotInfoViewControllerInput: AnyObject {
    var screenshotInfoViewController: ScreenshotInfoViewControllerOutput? { get set }
    func getCreationDateString() -> String?
    func getName() -> String?
    func getSizeInfo() -> String?
    func getPredictionText() -> String?
}

protocol ScreenshotInfoViewControllerOutput: AnyObject {

}
