//
//  ScreenShotsGalleryViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 01/10/23.
//

import UIKit

class ScreenShotsGalleryViewController: UIViewController {

    private let viewModel: ScreenShotsGalleryViewModelInput

    init(viewModel: ScreenShotsGalleryViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ScreenShotsGalleryViewController.self), bundle: nil)
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

extension ScreenShotsGalleryViewController: ScreenShotsGalleryViewModelOutput {
    
}
