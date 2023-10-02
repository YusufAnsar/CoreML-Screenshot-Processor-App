//
//  ScreenShotInfoViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import UIKit

class ScreenShotInfoViewController: UIViewController {

    private let viewModel: ScreenshotInfoViewModelInput

    init(viewModel: ScreenshotInfoViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ScreenShotInfoViewController.self), bundle: nil)
        viewModel.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ScreenShotInfoViewController: ScreenshotInfoViewModelOutput {
    
}
