//
//  ScreenShotsGalleryViewModel.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 01/10/23.
//

import Foundation


protocol ScreenShotsGalleryViewModelInput: AnyObject {
    var viewController: ScreenShotsGalleryViewModelOutput? { get set }
}

protocol ScreenShotsGalleryViewModelOutput: AnyObject {

}

final class ScreenShotsGalleryViewModel {

    weak var viewController: ScreenShotsGalleryViewModelOutput?

    init() {

    }
}


extension ScreenShotsGalleryViewModel: ScreenShotsGalleryViewModelInput {

}



