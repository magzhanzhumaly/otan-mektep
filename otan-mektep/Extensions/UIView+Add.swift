//
//  UIView+Add.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 14.12.2023.
//

import UIKit

extension UIView {
    func insertFilledSubview(_ subview: UIView, at index: Int, with insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(subview, at: index)
        addFillConstraints(for: subview, with: insets)
    }

    func addFilledSubview(_ subview: UIView, with insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addFillConstraints(for: subview, with: insets)
    }
    
    private func addFillConstraints(for subview: UIView, with insets: UIEdgeInsets) {
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    func roundSelectedCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        layer.masksToBounds = true
    }
}

