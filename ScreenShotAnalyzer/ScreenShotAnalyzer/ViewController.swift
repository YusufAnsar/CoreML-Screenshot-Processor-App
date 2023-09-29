//
//  ViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 27/09/23.
//

import UIKit
import Photos

class ViewController: UIViewController {

    var allPhotos: PHFetchResult<PHAsset>? = nil
    var images: [UIImage] = []

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        /// Load Photos
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
//                let fetchOptions = PHFetchOptions()
//                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                    self.getPhotos()
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            case .limited:
                    print("limited permission")
            @unknown default:
                    print("unknown case")
            }
        }
    }


    fileprivate func getPhotos() {
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
                let size = CGSize(width: 700, height: 700)
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        self.images.append(image)
                        print("count: \(self.images.count)")
                        self.imageView.image = image
                        // self.collectionView.reloadData()
                    } else {
                        print("error asset to image")
                    }
                }
            }
        } else {
            print("no photos to display")
        }

    }



}



