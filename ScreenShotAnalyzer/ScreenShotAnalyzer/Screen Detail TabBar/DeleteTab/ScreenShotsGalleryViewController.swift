//
//  ScreenShotsGalleryViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 01/10/23.
//

import UIKit

class ScreenShotsGalleryViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var bottomImagesCollectionView: UICollectionView!

    private let viewModel: ScreenShotsGalleryViewControllerInput
    private var pageViewController: UIPageViewController?

    var indexSelected: Int {
        get {
            return viewModel.getCurrentSelectedIndex()
        }
        set {
            viewModel.set(currentSelectedIndex: newValue)
        }
    }

    var viewControllers: [ScreenshotDetailsViewController] {
        return viewModel.getScreenshotDetailsViewControllers()
    }

    init(viewModel: ScreenShotsGalleryViewControllerInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ScreenShotsGalleryViewController.self), bundle: nil)
        viewModel.galleryViewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageViewController()
        setupBottomCollectionView()
    }

    private func setupPageViewController() {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        pageVC.delegate = self
        add(pageVC, onContentView: contentView)
        pageViewController = pageVC
        if let currentViewController = viewModel.getCurrentViewController() {
            pageVC.setViewControllers([currentViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    private func setupBottomCollectionView() {
        bottomImagesCollectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constant.collectionViewSpacing
        layout.minimumLineSpacing = Constant.collectionViewSpacing
        layout.itemSize = CGSize(width: Constant.itemImageCellWidthDimension,
                                 height: Constant.itemImageCellHeightDimension)

        layout.sectionInset =  Constant.collectionViewSectionInset
        bottomImagesCollectionView.collectionViewLayout = layout
        bottomImagesCollectionView.dataSource = self
        bottomImagesCollectionView.delegate = self
        bottomImagesCollectionView.reloadData()
    }

    private func switchToImage(at index: Int) {
        // if new index is not current slected index
        guard indexSelected != index else {
            return
        }
        let direction: UIPageViewController.NavigationDirection
        if index > indexSelected {
            direction = .forward
        } else {
            direction = .reverse
        }
        setupViewsAfterScroll(on: index)
        if let currentViewController = viewModel.getCurrentViewController() {
            pageViewController?.setViewControllers([currentViewController], direction: direction, animated: true, completion: nil)
        }
    }

    private func setupViewsAfterScroll(on index: Int) {
        guard indexSelected != index else {
            return
        }

        // Remove indicator from previous cell
        guard let prevCell = bottomImagesCollectionView.cellForItem(at: IndexPath(row: indexSelected,
                                                                                  section: 0)) as? CarouselCollectionViewCell
            else { return }
        prevCell.removeBorder()

        // change the bottom image indicator for selected cell
        guard let cell = bottomImagesCollectionView.cellForItem(at: IndexPath(row: index,
                                                                              section: 0)) as? CarouselCollectionViewCell
            else { return }
        cell.addBorder(with: .black, onIndex: index)
        indexSelected = index
        setHeaderText()
    }

    private func setHeaderText() {

    }

}

// MARK: - UIPageViewControllerDataSource
extension ScreenShotsGalleryViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let imageFullScreenVC = viewController as? ScreenshotDetailsViewController,
              let currentPageIndex = viewControllers.firstIndex(of: imageFullScreenVC) else {
            return nil
        }
        let pageIndex = currentPageIndex - 1
        if pageIndex >= 0, pageIndex < viewControllers.count {
            return viewControllers[pageIndex]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let imageFullScreenVC = viewController as? ScreenshotDetailsViewController,
            let currentPageIndex = viewControllers.firstIndex(of: imageFullScreenVC) else {
            return nil
        }
        let pageIndex = currentPageIndex + 1
        if pageIndex >= 0, pageIndex < viewControllers.count {
            return viewControllers[pageIndex]
        } else {
            return nil
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegate & UICollectionViewDataSource
extension ScreenShotsGalleryViewController: UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getScreenShots().count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let screenshot = viewModel.getScreenShots()[indexPath.item] as? ScreenshotModel {
            cell.setImage(image: screenshot.image)
        }
        if indexSelected == indexPath.row {
            cell.addBorder(with: .black, onIndex: indexPath.row)
        } else {
            cell.addBorder(with: .clear, onIndex: indexPath.row)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let cellWidth: CGFloat = flowLayout?.itemSize.width ?? 0.0
        let cellSpacing: CGFloat = flowLayout?.minimumInteritemSpacing ?? 0.0
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
        let collectionWidth = collectionView.frame.size.width
        let totalWidth = cellWidth * cellCount + cellSpacing * (cellCount - 1)

        if totalWidth <= collectionWidth {
            let edgeInset = (collectionWidth - totalWidth) / 2
            return UIEdgeInsets(top: flowLayout?.sectionInset.top ?? 0.0,
                                left: edgeInset,
                                bottom: flowLayout?.sectionInset.bottom ?? 0.0,
                                right: edgeInset)
        } else {
            return flowLayout?.sectionInset ?? .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switchToImage(at: indexPath.item)
    }
}

extension ScreenShotsGalleryViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed, let viewController = pageViewController.viewControllers?.first,
              let screenshotDetailsVC = viewController as? ScreenshotDetailsViewController,
              let updatedIndex = self.viewControllers.firstIndex(of: screenshotDetailsVC) else {
            return
        }
        setupViewsAfterScroll(on: updatedIndex)
    }
}

extension ScreenShotsGalleryViewController: ScreenShotsGalleryViewControllerOutput {
    func reloadPage() {
        bottomImagesCollectionView.reloadData()
        if let currentViewController = viewModel.getCurrentViewController() {
            pageViewController?.setViewControllers([currentViewController], direction: .forward, animated: false, completion: nil)
        }
    }
}

extension ScreenShotsGalleryViewController {
    // MARK: - Constants
    private enum Constant {
        static let itemImageCellWidthDimension: CGFloat = 60
        static let itemImageCellHeightDimension: CGFloat = 56
        static let collectionViewSpacing: CGFloat = 4
        static let collectionViewSectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
