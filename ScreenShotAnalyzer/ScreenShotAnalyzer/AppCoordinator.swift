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
        let screenshotsVC = ScreenshotsViewController(viewModel: viewModel)
        navigationController.setViewControllers([screenshotsVC], animated: false)
    }
}
