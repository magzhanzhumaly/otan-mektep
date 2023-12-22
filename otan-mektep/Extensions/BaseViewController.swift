//
//  BaseViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 22.12.2023.
//

import UIKit

class BaseViewController: UIViewController {
    // Navigation Actions
    private var actions: [Navigation.Action] = []
    private var isFirstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil,
                                               queue: .main) { notification in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let y = keyboardSize.minY
                let bottomInset = self.view.bounds.height - y
                self.updateBottomInset(bottomInset)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstTime {
            DispatchQueue.main.async {
                self.updateSizeRelatedUI()
            }
            isFirstTime = false
        }
    }

    func updateUI() {}
    
    func updateSizeRelatedUI() {}
    
    func setActions(_ newActions: [Navigation.Action]) {
        actions = newActions
    }
    
    func updateBottomInset(_ bottom: CGFloat) {}
}

