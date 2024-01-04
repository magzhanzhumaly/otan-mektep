//
//  PupilDiningViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 22.12.2023.
//

import UIKit
import FirebaseAuth
class PupilDiningChooseOptionViewController: UIViewController {

    var user: User?
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var foodChoiceCellView: UIView!
    @IBOutlet weak var limitsCellView: UIView!
    @IBOutlet weak var historyCellView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let topSeparator = UIView()
        let bottomSeparator = UIView()
        
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        topSeparator.backgroundColor = .gray200
        bottomSeparator.backgroundColor = .gray200
        
        view.addSubview(topSeparator)
        view.addSubview(bottomSeparator)
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            bottomSeparator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])

        topSeparator.isHidden = true
        
        user = Auth.auth().currentUser
//        navItem.title = "fjdksf"
        let name = user?.email ?? ""
//        welcomeLabel.text = "Добро пожаловать,\n\(name)!"
        
        let texxt = "Добро пожаловать,\n\(name)!"
        let label = UILabel()
        label.text = texxt
        label.numberOfLines = 0
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            label.heightAnchor.constraint(equalToConstant: 50+20), // fix!!
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        navItem.titleView?.addSubview(label)
        foodChoiceCellView.addFilledSubview(FlexibleCell(input: .init(leftIcon: .init(icon: .other(image: UIImage(named: "food-active-icon") ?? UIImage()), color: nil), title: .init(text: "Выбор еды", isBold: false, isLarge: true), components: .init(input: .icon(icon: .next), color: .inactive), corners: .init(isRounded: false), closure: {[weak self] in
            self?.performSegue(withIdentifier: "pupilDiningAddToCartVCSegue", sender: self)})))
        
        limitsCellView.addFilledSubview(FlexibleCell(input: .init(leftIcon: .init(icon: .other(image: UIImage(named: "limit-active-icon") ?? UIImage()), color: nil), title: .init(text: "Лимиты", isBold: false, isLarge: true), components: .init(input: .icon(icon: .next), color: .inactive), corners: .init(isRounded: false), closure: {})))

        historyCellView.addFilledSubview(FlexibleCell(input: .init(leftIcon: .init(icon: .other(image: UIImage(named: "history-active-icon") ?? UIImage()), color: nil), title: .init(text: "История", isBold: false, isLarge: true), components: .init(input: .icon(icon: .next), color: .inactive), corners: .init(isRounded: false), closure: {})))
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
