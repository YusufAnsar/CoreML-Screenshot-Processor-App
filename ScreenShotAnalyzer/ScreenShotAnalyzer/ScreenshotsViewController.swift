//
//  ScreenshotsViewController.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 29/09/23.
//

import UIKit

class ScreenshotsViewController: UIViewController {

    private let viewModel: ScreenshotsViewModelInput

    init(viewModel: ScreenshotsViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ScreenshotsViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
