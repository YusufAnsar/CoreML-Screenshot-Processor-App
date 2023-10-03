//
//  ScreenshotModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import UIKit

class ScreenshotModel {
    let name: String?
    let image: UIImage
    let creationDate: Date?
    let imageSize: Float?
    let pixelWidth, pixelHeight: Int
    var note: String?
    var predictionOutput: String?

    init(name: String?, image: UIImage, creationDate: Date?, imageSize: Float?, pixelWidth: Int, pixelHeight: Int) {
        self.name = name
        self.image = image
        self.creationDate = creationDate
        self.imageSize = imageSize
        self.pixelWidth = pixelWidth
        self.pixelHeight = pixelHeight
    }
}
