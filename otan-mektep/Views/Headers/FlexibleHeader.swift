//
//  FlexibleHeader.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 28.12.2023.
//

import UIKit

class FlexibleHeader: UIView {
    
    struct Input {
        let firstComponent: String
        let secondComponent: String? // for one component situation
        let thirdComponent: String?  // for sorting
        let isSmall: Bool
    }
    
    init(input: Input) {
        super.init(frame: .zero)

        let firstLabel = UILabel()
        firstLabel.text = input.firstComponent
  
        self.addSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if input.isSmall {
            self.heightAnchor.constraint(equalToConstant: 14+14+30).isActive = true
            firstLabel.font = Fonts.headline17.font
        } else {
            self.heightAnchor.constraint(equalToConstant: 40).isActive = true
            firstLabel.font = Fonts.title2Bold22.font
        }
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
        if input.secondComponent != nil && input.thirdComponent != nil { // two components
            
            let secondLabel = UILabel()
            let thirdLabel = UILabel()
            
            secondLabel.translatesAutoresizingMaskIntoConstraints = false
            thirdLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(secondLabel)
            self.addSubview(thirdLabel)
            
            secondLabel.text = input.secondComponent
            thirdLabel.text = input.thirdComponent
            
            firstLabel.font = Fonts.headline17.font
            secondLabel.font = Fonts.caption1Bold12.font
            thirdLabel.font = Fonts.caption1Bold12.font
            
            let stackView = UIStackView()
            
            stackView.axis = .horizontal
            stackView.spacing = 0
            stackView.distribution = .fillEqually
            
            self.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(secondLabel)
            stackView.addArrangedSubview(thirdLabel)
            
            NSLayoutConstraint.activate([
                firstLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                firstLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
                
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
            ])
            
        } else {
            if input.secondComponent != nil && input.thirdComponent == nil { // one component
                
                let secondLabel = UILabel()
                secondLabel.text = input.secondComponent
                secondLabel.font = Fonts.calloutBold16.font
                
                self.addSubview(secondLabel)
                secondLabel.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    secondLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    secondLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
                ])
                
            } else if input.secondComponent == nil && input.thirdComponent != nil { // sort
                
                let sortImageView = UIImageView()
                sortImageView.image = UIImage(named: "sort-icon")
                
                let thirdLabel = UILabel()
                thirdLabel.text = input.thirdComponent
                thirdLabel.font = Fonts.calloutBold16.font
                thirdLabel.textAlignment = .right
                thirdLabel.numberOfLines = 2
                thirdLabel.text = "Сортировка:\n\(input.thirdComponent ?? "")"
                
                self.addSubview(thirdLabel)
                self.addSubview(sortImageView)
                
                thirdLabel.translatesAutoresizingMaskIntoConstraints = false
                sortImageView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    sortImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    sortImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
                    sortImageView.heightAnchor.constraint(equalToConstant: 26),
                    sortImageView.widthAnchor.constraint(equalToConstant: 26),
                    
                    thirdLabel.trailingAnchor.constraint(equalTo: sortImageView.leadingAnchor),
                    thirdLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
                    thirdLabel.heightAnchor.constraint(equalToConstant: 26),
                ])
                
            } else { // no components
                
            }
            NSLayoutConstraint.activate([
                firstLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                firstLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
                
//                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
//                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
