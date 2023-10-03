//
//  ScreenshotDetailsViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 03/10/23.
//

import UIKit

class ScreenshotDetailsViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var noteTextField: UITextField!
    @IBOutlet private weak var creationDateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    @IBOutlet private weak var predictionsLabel: UILabel!

    private let viewModel: ScreenshotDetailsViewModelInput

    init(viewModel: ScreenshotDetailsViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ScreenshotDetailsViewController.self), bundle: nil)
        viewModel.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        noteTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        noteTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = viewModel.getScreenshotImage()
        noteTextField.text = viewModel.getScreenshotNote()
        creationDateLabel.text = viewModel.getCreationDateString()
        nameLabel.text = viewModel.getName()
        sizeLabel.text = viewModel.getSizeInfo()
        predictionsLabel.text = viewModel.getPredictionText()
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.update(screenshotNote: textField.text)
    }
}

extension ScreenshotDetailsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ScreenshotDetailsViewController: ScreenshotDetailsViewModelOutput {

}


