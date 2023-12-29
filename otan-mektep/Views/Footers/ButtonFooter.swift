//
//  ButtonCell.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 28.12.2023.
//

import UIKit

class ButtonFooter: UIView {

    struct Input {
        let title: String
        let color: UIColor
        let icon: UIImage?
        let closure: (() -> Void)?
    }
    
    private var actionClosure: (() -> Void)?
    
    @objc func tapAction() {
        actionClosure?()
    }

    init(input: Input) {
        
        super.init(frame: .zero)
        
        actionClosure = input.closure

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)

        let label = UILabel()
        label.text = input.title
        label.font = Fonts.headline17.font
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        
        if let image = input.icon {
            let icon = UIImageView()
            
            icon.image = image.withTintColor(input.color)
            stackView.addArrangedSubview(icon)
        }
        
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 70),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
