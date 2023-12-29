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

//        navItem.title = "fjdksf"
        let name = "Мағжан Жұмалы"
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
            label.widthAnchor.constraint(equalToConstant: 200),
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
