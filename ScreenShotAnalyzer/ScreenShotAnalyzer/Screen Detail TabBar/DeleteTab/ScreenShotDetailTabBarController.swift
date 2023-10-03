//
//  ScreenShotDetailTabBarController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import UIKit

class ScreenShotDetailTabBarController: UITabBarController {
    private let shareVC: UIViewController
    private let screenShotInfoViewController: ScreenShotInfoViewController
    private let screenShotsGalleryViewController: ScreenShotsGalleryViewController
    private var currentViewController: UIViewController?
    private let viewModel: ScreenShotDetailTabBarViewModelInput

    init(withViewModel viewModel: ScreenShotDetailTabBarViewModelInput,
         screenShotInfoViewController: ScreenShotInfoViewController,
         screenshotsGalleryViewController: ScreenShotsGalleryViewController) {
        self.viewModel = viewModel
        self.shareVC = UIViewController()
        self.screenShotInfoViewController = screenShotInfoViewController
        self.screenShotsGalleryViewController = screenshotsGalleryViewController
        super.init(nibName: nil, bundle: nil)
        viewModel.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let shareTab = UITabBarItem(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), selectedImage: UIImage(systemName: "square.and.arrow.up"))
        shareVC.tabBarItem = shareTab

        let infoTab = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
        screenShotInfoViewController.tabBarItem = infoTab

        let deleteTab = UITabBarItem(title: "Delete", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        screenShotsGalleryViewController.tabBarItem = deleteTab

        viewControllers = [shareVC, screenShotInfoViewController, screenShotsGalleryViewController]
        selectedIndex = 2
        currentViewController = screenShotsGalleryViewController
        delegate = self
    }

    private func showShareActivity() {
        let image = UIImage(systemName: "info.circle")
        let imageShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

}


extension ScreenShotDetailTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController === shareVC {
            showShareActivity()
            return false
        }
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController === screenShotsGalleryViewController, currentViewController === screenShotsGalleryViewController {
            viewModel.deleteCurrentScreenshot()
        }
        currentViewController = viewController
    }
}

extension ScreenShotDetailTabBarController: ScreenShotDetailTabBarViewModelOutput {

}

