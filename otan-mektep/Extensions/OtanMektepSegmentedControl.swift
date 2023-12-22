//
//  OtanMektepSegmentedControl.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 22.12.2023.
//

import UIKit

class OtanMektepSegment: UIView {
    struct Input {
        let titles: [Navigation.Action.Info]
        let actionClosure: (Int) -> Void
    }

    private(set) var selectedIndex: Int
    let input: Input

    init(input: Input, selectedIndex: Int = 0) {
        self.input = input
        self.selectedIndex = selectedIndex
        super.init(frame: .zero)

        let control = UISegmentedControl()
        input.titles.enumerated().forEach { (index, info) in
            switch info {
            case .text(let text):
                control.insertSegment(withTitle: text, at: index, animated: false)
            case .image(let image):
                control.insertSegment(with: image, at: index, animated: false)
            }
        }
        control.selectedSegmentIndex = selectedIndex
        control.addTarget(self, action: #selector(action(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false

        self.addFilledSubview(control)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func action(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
        input.actionClosure(sender.selectedSegmentIndex)
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

