//
//  OtanMektepButton.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 15.12.2023.
//

import UIKit

protocol OtanMektepButtonDelegate: AnyObject {
    func buttonTapped()
}

class OtanMektepButton: UIView {

    struct Input {
        let isLarge: Bool
        let isFilled: Bool
        let text: String
        let color: UIColor?
        let closure: (() -> Void)?
    }
    
    weak var delegate: FlexibleCellButtonDelegate?
    private var actionClosure: (() -> Void)?

    @objc func tapAction() {
        actionClosure?()
    }
    
    init(input: Input) {
        super.init(frame: .zero)
        
        actionClosure = input.closure

        let button = UIButton()
        
        self.addFilledSubview(button)
        
        if let color = input.color {
            button.backgroundColor = color
        } else {
            button.backgroundColor = Colors.accentColor.color
        }
        
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
