//
//  AppCoordinator.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 29/09/23.
//

import UIKit

class AppCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showScreenshotsScreen()
    }

    private func showScreenshotsScreen() {
        let viewModel = ScreenshotsViewModel()
        viewModel.coordinatorDelegate = self
        let screenshotsVC = ScreenshotsViewController(viewModel: viewModel)
        navigationController.setViewControllers([screenshotsVC], animated: false)
    }
}

extension AppCoordinator: ScreenshotsViewModelCoordinatorDelegate {

    func screenshotsViewModel(_ viewModel: ScreenshotsViewModel, didSelectImageAtIndex index: Int) {
        let tabBarViewModel = ScreenShotDetailTabBarViewModel(screenshots: viewModel.screenshots, selectedIndex: index)
        let screenshotInfoVC = ScreenShotInfoViewController(viewModel: tabBarViewModel)
        let screenShotsGalleryVC = ScreenShotsGalleryViewController(viewModel: tabBarViewModel)

        let tabBarController = ScreenShotDetailTabBarController(withViewModel: tabBarViewModel, screenShotInfoViewController: screenshotInfoVC, screenshotsGalleryViewController: screenShotsGalleryVC)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
