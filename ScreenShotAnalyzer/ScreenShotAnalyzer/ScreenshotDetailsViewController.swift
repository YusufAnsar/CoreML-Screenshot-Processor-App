//
//  ScreenshotDetailsViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 03/10/23.
//

import UIKit

class ScreenshotDetailsViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
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

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.update(screenshotNote: textField.text)
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        var scrollRect = self.view.frame;
        scrollRect.size.height -= keyboardViewEndFrame.height
        if !scrollRect.contains(noteTextField.frame.origin) {
            let scrollPoint = CGPoint(x: 0, y: noteTextField.frame.origin.y - keyboardScreenEndFrame.height)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
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


