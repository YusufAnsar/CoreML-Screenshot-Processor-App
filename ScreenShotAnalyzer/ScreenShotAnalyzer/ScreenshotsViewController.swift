//
//  ScreenshotsViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 29/09/23.
//

import UIKit

class ScreenshotsViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    private let viewModel: ScreenshotsViewModelInput

    init(viewModel: ScreenshotsViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ScreenshotsViewController.self), bundle: nil)
        viewModel.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenshotCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        viewModel.importPhotos()
    }
}


extension ScreenshotsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count \(viewModel.images.count)")
        return viewModel.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCollectionViewCell", for: indexPath) as? ScreenshotCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.screenshotImageView.image = viewModel.images[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
        let width = floor((collectionView.frame.width - 20) / 3)
        let height = width * heightRatio
        return CGSize(width: width, height: height)
    }

}

extension ScreenshotsViewController: ScreenshotsViewModelOutput {

    func reloadScreenshots() {
        titleLabel.text = "\(viewModel.images.count) screenshots imported"
        collectionView.reloadData()
    }
}
