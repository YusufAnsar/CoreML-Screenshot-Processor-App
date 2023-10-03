//
//  ScreenshotsViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 29/09/23.
//

import UIKit
import Photos
import Vision

protocol ScreenshotsViewModelInput: AnyObject {
    var viewController: ScreenshotsViewModelOutput? { get set }
    var screenshots: NSMutableArray { get set }
    func importPhotos()
    func didSelectImage(at index: Int)
}

protocol ScreenshotsViewModelOutput: AnyObject {
    func reloadScreenshots()
}

final class ScreenshotsViewModel {

    lazy var screenshots = NSMutableArray()
    weak var viewController: ScreenshotsViewModelOutput?
    weak var coordinatorDelegate: ScreenshotsViewModelCoordinatorDelegate?
    private static let maxPredictions = 10

    init() {

    }

    private func getAllPhotos() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        // .highQualityFormat will return better quality photos
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "(mediaSubtype & %d) != 0", PHAssetMediaSubtype.photoScreenshot.rawValue)
        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                manager.requestImageDataAndOrientation(for: asset, options: requestOptions) { [weak self] data, _, _, _ in
                    guard let self = self else {
                        return
                    }
                    let assetRes = PHAssetResource.assetResources(for: asset)
                    let name = assetRes.first?.originalFilename
                    if let data = data, let image = UIImage(data: data) {
                        //Get bytes size of image
                        var imageSize = Float(data.count)
                        //Transform into Megabytes
                        imageSize = imageSize/(1024*1024)
                        let screenshotModel = ScreenshotModel(name: name,
                                                              image: image,
                                                              creationDate: asset.creationDate,
                                                              imageSize: imageSize,
                                                              pixelWidth: asset.pixelWidth,
                                                              pixelHeight: asset.pixelHeight)
                        DispatchQueue.main.async {
                            self.screenshots.add(screenshotModel)
                            self.viewController?.reloadScreenshots()
                        }
                        self.process(screenshot: screenshotModel)
                    } else {
                        print("error asset to image")
                    }
                }
            }
        } else {
            print("no photos to display")
        }
    }

    private func process(screenshot: ScreenshotModel) {
        if let cgImage = screenshot.image.cgImage {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage)

          let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
            // 1. Parse the results
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
              return
            }

            // 2. Extract the data you want
            let recognizedStrings = observations.compactMap { observation in
              observation.topCandidates(1).first?.string
            }
              screenshot.predictionOutput = recognizedStrings.joined(separator: " ")
          }

          recognizeTextRequest.recognitionLevel = .fast

          DispatchQueue.global(qos: .userInitiated).async {
            do {
              try requestHandler.perform([recognizeTextRequest])
            } catch {
              print(error)
            }
          }
        }
    }
}

extension ScreenshotsViewModel: ScreenshotsViewModelInput {

    func importPhotos() {
        /// Load Photos
        PHPhotoLibrary.requestAuthorization { [weak self] (status) in
            guard let self = self else { return }
            switch status {
            case .authorized:
                print("Good to proceed")
                self.getAllPhotos()
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            case .limited:
                print("permission is limited")
            @unknown default:
                print("unknown permission status")
            }
        }
    }

    func didSelectImage(at index: Int) {
        coordinatorDelegate?.screenshotsViewModel(self, didSelectImageAtIndex: index)
    }

}
