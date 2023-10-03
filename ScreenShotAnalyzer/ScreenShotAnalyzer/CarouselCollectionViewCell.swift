//
//  CarouselCollectionViewCell.swift
//  ScreenShotAnalyzer
//
//  Created by maple on 03/10/23.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var itemImageView: UIImageView! {
        didSet {
            itemImageView.layer.cornerRadius = 4
        }
    }

    func setImage(image: UIImage) {
        itemImageView.image = image
    }

    func addBorder(with color: UIColor? = .clear, onIndex selectedIndex: Int?) {
        transform = CGAffineTransform(translationX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(selectedIndex ?? 1),
                       options: [.curveEaseInOut], animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
            self.itemImageView.layer.borderWidth = 2
            self.itemImageView.layer.borderColor = color?.cgColor
        }, completion: nil)
    }

    func removeBorder() {
        itemImageView.layer.borderColor = UIColor.clear.cgColor
    }
}
