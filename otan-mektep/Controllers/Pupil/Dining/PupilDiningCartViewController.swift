//
//  PupilDiningCartViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit

class PupilDiningCartViewController: UIViewController {
    
    var cart = Cart()

    @IBOutlet weak var tableView: UITableView!
    
    var totalCost = 0
    var onePurchaseLimit = 1000
    var dailyLimit = 3000
    var spentToday = 1800
    
    let totalCostLabel = UILabel()
    let detailsLabel = UILabel()
    let buttonContainer = UIView()
    let lowerView = UIView()
    let goToCartButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()        

        print("---cart---")
        
        for food in cart.addedItems {
            print("\(food.foodTitle), \(food.count)")
        }

        
        
//        let rightBarButtonItem = UIBarButtonItem(title: "Оплатить", style: .plain, target: self, action: #selector(payButtonTapped))
//        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        tableView.register(FlexibleTableViewCell.self, forCellReuseIdentifier: FlexibleTableViewCell.reuseIdentifier)

        
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
        
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        goToCartButton.translatesAutoresizingMaskIntoConstraints = false
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lowerView)
        lowerView.addSubview(goToCartButton)
        lowerView.addSubview(totalCostLabel)
        lowerView.addSubview(detailsLabel)
        
        totalCostLabel.text = "Итого: \(totalCost) ₸"

        detailsLabel.text = "Лимит разовой покупки: \(onePurchaseLimit) ₸\nЛимит на день: \(dailyLimit) ₸\nОсталось на день: \(dailyLimit - spentToday) ₸"

        totalCostLabel.font = Fonts.title3Bold20.font
        detailsLabel.font = Fonts.caption1Regular12.font
        
        detailsLabel.numberOfLines = 0
        totalCostLabel.numberOfLines = 0
        
        detailsLabel.textAlignment = .right
        
        goToCartButton.backgroundColor = .accent
        goToCartButton.setTitle("Оплатить", for: .normal)
        goToCartButton.setTitleColor(.white, for: .normal)
        goToCartButton.titleLabel?.font = Fonts.body17.font
        goToCartButton.layer.cornerRadius = 10
        
        goToCartButton.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            lowerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lowerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lowerView.bottomAnchor.constraint(equalTo: bottomSeparator.topAnchor),
            lowerView.heightAnchor.constraint(equalToConstant: 140),
                    
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: lowerView.topAnchor),
            
            
            totalCostLabel.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 26),
            totalCostLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            
            detailsLabel.centerYAnchor.constraint(equalTo: totalCostLabel.centerYAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            
            goToCartButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            goToCartButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            goToCartButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -20),
            goToCartButton.heightAnchor.constraint(equalToConstant: 44),
        ])
                
        tableView.separatorStyle = .none
        
        lowerView.backgroundColor = .accentColorLight
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

    }
    
    @objc func goToCart() {
    }
    
    @objc func payButtonTapped() {
        // Implement the action that should be performed when the button is tapped
    }
    
    private func recolorButton(text: String, bgColor: UIColor, textColor: UIColor, lowerViewBgColor: UIColor, lowerViewTextColor: UIColor) {
        goToCartButton.backgroundColor = bgColor
        goToCartButton.setTitleColor(textColor, for: .normal)
        goToCartButton.setTitle(text, for: .normal)
        
        lowerView.backgroundColor = lowerViewBgColor
        detailsLabel.textColor = lowerViewTextColor
        totalCostLabel.textColor = lowerViewTextColor
    }

}

extension PupilDiningCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.addedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlexibleTableViewCell.reuseIdentifier, for: indexPath) as! FlexibleTableViewCell
        
        let input: FlexibleTableViewCell.Input = .init(leftIcon: nil, title: .init(text: cart.addedItems[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(cart.addedItems[indexPath.row].price) ₸", lowerText: "Выбрано: \(cart.addedItems[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
            
        
        cell.setup(input: input)
        
        cell.removeClosure = { [weak self] in
            
            guard let strongSelf = self else { return }

            print("Tapped cell at indexPath: \(indexPath)")

            let foodTitleToDecrement = input.title.text

            print("----- CART ----- tapped \(String(describing: foodTitleToDecrement))")
            for food in strongSelf.cart.addedItems {
                
                if food.foodTitle != foodTitleToDecrement {
                    print("\(food.count) \(food.foodTitle), \(food.price) тг")
                } else {
                    print("\(food.count - 1) \(food.foodTitle), \(food.price) тг")

                    food.count -= 1
                    strongSelf.totalCost -= food.price
                    
                    cell.changeChosenCount(newNum: food.count)

                    if food.count == 0 {
                        cell.removeButton?.isHidden = true
                        
                        strongSelf.cart.addedItems = strongSelf.cart.addedItems.filter{$0.foodTitle != food.foodTitle}
                    }
                    
                    if strongSelf.cart.addedItems.isEmpty {
                        strongSelf.recolorButton(text: "Корзина пуста", bgColor: .accent, textColor: .white, lowerViewBgColor: .accentColorLight, lowerViewTextColor: .black)
                    }
                }
                
            }
            
            
            
            strongSelf.totalCostLabel.text = "Итого: \(strongSelf.totalCost) ₸"

        }
        
        cell.removeButton?.isHidden = true
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerView = UIView()
        var view: FlexibleHeader?
        
            
        view = FlexibleHeader.init(input: .init(firstComponent: "Вы выбрали", secondComponent: nil, thirdComponent: nil, isSmall: false))
            
        containerView.addSubview(view!)
        view!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view!.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            view!.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20),
            view!.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            view!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ])
        
        return containerView
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
