//
//  ScreenShotInfoViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 02/10/23.
//

import UIKit

class ScreenShotInfoViewController: UIViewController {

    @IBOutlet private weak var creationDateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    @IBOutlet private weak var predictionsLabel: UILabel!

    private let viewModel: ScreenshotInfoViewControllerInput

    init(viewModel: ScreenshotInfoViewControllerInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ScreenShotInfoViewController.self), bundle: nil)
        viewModel.screenshotInfoViewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        creationDateLabel.text = viewModel.getCreationDateString()
        nameLabel.text = viewModel.getName()
        sizeLabel.text = viewModel.getSizeInfo()
        predictionsLabel.text = viewModel.getPredictionText()
    }

}

extension ScreenShotInfoViewController: ScreenshotInfoViewControllerOutput {
    
}
