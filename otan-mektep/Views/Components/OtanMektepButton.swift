//
//  OtanMektepButton.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 15.12.2023.
//

import UIKit

class OtanMektepButton: UIView {

    struct Input {
        let isLarge: Bool
        let isFilled: Bool
        let text: String
    }
    
    init(input: Input) {
        super.init(frame: .zero)
        
        let button = UIButton()
        
        self.addFilledSubview(button)
        
        button.backgroundColor = Colors.accentColor.color
        button.layer.cornerRadius = 10
        button.setTitle(input.text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.headline17.font
        button.titleLabel?.textAlignment = .center
        
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
//        self.backgroundColor = UIColor(named: )
//        button.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
