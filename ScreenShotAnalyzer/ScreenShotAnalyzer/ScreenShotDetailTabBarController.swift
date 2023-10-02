//
//  ScreenShotDetailTabBarController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import UIKit

class ScreenShotDetailTabBarController: UITabBarController {
    let shareVC: UIViewController
    let screenShotInfoViewController: ScreenShotInfoViewController
    let screenShotsGalleryViewController: ScreenShotsGalleryViewController

    init(withScreenShotInfoViewController screenShotInfoViewController: ScreenShotInfoViewController,
         screenshotsGalleryViewController: ScreenShotsGalleryViewController) {
        self.shareVC = UIViewController()
        self.screenShotInfoViewController = screenShotInfoViewController
        self.screenShotsGalleryViewController = screenshotsGalleryViewController
        super.init(nibName: nil, bundle: nil)
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

        self.viewControllers = [shareVC, screenShotInfoViewController, screenShotsGalleryViewController]
        self.selectedIndex = 2
        self.delegate = self
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

    }
}

