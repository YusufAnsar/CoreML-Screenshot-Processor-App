//
//  ScreenshotsViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 29/09/23.
//

import UIKit
import Photos

protocol ScreenshotsViewModelInput: AnyObject {
    var viewController: ScreenshotsViewModelOutput? { get set }
    var images: [UIImage] { get set }
    func importPhotos()
}

protocol ScreenshotsViewModelOutput: AnyObject {
    func reloadScreenshots()
}

final class ScreenshotsViewModel {

    lazy var images: [UIImage] = []
    weak var viewController: ScreenshotsViewModelOutput?

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
                manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: requestOptions) { [weak self] (image, _) in
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        if let image = image {
                            self.images.append(image)
                            self.viewController?.reloadScreenshots()
                        } else {
                            print("error asset to image")
                        }
                    }
                }
            }
        } else {
            print("no photos to display")
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

}
