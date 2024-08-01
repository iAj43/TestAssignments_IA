//
//  Extensions.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit

extension UIColor {
    static let themeBackgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.97, alpha: 1.00) // #F4FBF8
    static let themeButtonColor = UIColor(red: 0.17, green: 0.60, blue: 0.94, alpha: 1.00) // #2C98F0
}

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        self.layer.shadowOpacity = 0.5
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, duration: CGFloat) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension CALayer {
    func applyCornerRadiusShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0,
        cornerRadiusValue: CGFloat = 0
    ) {
        cornerRadius = cornerRadiusValue
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
