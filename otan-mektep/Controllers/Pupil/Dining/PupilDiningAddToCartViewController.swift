//
//  PupilDiningAddToCartViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit

class PupilDiningAddToCartViewController: UIViewController  {
    
    let totalCostLabel = UILabel()
    let detailsLabel = UILabel()
    let buttonContainer = UIView()
    let lowerView = UIView()
    let goToCartButton = UIButton()

//    class FoodObject {
//        let foodTitle: String
//        let price: Int
//        var count: Int
//        let type: FoodTypes
//        
//        init(foodTitle: String, price: Int, count: Int, type: FoodTypes) {
//            self.foodTitle = foodTitle
//            self.price = price
//            self.count = count
//            self.type = type
//        }
//        
//        init(foodTitle: String, price: Int, type: FoodTypes) {
//            self.foodTitle = foodTitle
//            self.price = price
//            self.count = 0
//            self.type = type
//        }
//    }
//    
//    enum FoodTypes {
//        case dough
//        case beverage
//        case soup
//        case meal
//    }
//    
//    class Cart {
//        var addedItems: [FoodObject] = []
//    }
//    
    var cart = Cart()
//    
    var foodTypeObjects = [FoodTypes]()
    
    
    var totalCost = 0
    var onePurchaseLimit = 1000
    var dailyLimit = 3000
    var spentToday = 1800

    func onCancel() {
        AppUtility.onCancel(self, true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("allowedDoughObjects:")
        
        for obj in allowedDoughObjects {
            print("\(obj.foodTitle), \(obj.count), \(obj.price) тг")
        }
        
        print("\n")
        
        print("allowedBeverageObjects:")
        
        for obj in allowedBeverageObjects {
            print("\(obj.foodTitle), \(obj.count), \(obj.price) тг")
        }
        
        print("\n")

        print("allowedSoupObjects:")
        
        for obj in allowedSoupObjects {
            print("\(obj.foodTitle), \(obj.count), \(obj.price) тг")
        }
        
        print("\n")

        print("allowedMealObjects:")
        
        for obj in allowedMealObjects {
            print("\(obj.foodTitle), \(obj.count), \(obj.price) тг")
        }

        
        
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
        goToCartButton.setTitle("Перейти в корзину", for: .normal)
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
    
    private func recolorButton(text: String, bgColor: UIColor, textColor: UIColor, lowerViewBgColor: UIColor, lowerViewTextColor: UIColor) {
        goToCartButton.backgroundColor = bgColor
        goToCartButton.setTitleColor(textColor, for: .normal)
        goToCartButton.setTitle(text, for: .normal)
        
        lowerView.backgroundColor = lowerViewBgColor
        detailsLabel.textColor = lowerViewTextColor
        totalCostLabel.textColor = lowerViewTextColor
    }
    
    @objc func goToCart() {
        
        if totalCost <= 0 {
            recolorButton(text: "Вы ничего не выбрали", bgColor: .danger500, textColor: .white, lowerViewBgColor: .danger50, lowerViewTextColor: .danger500)
                        
            let timeInSeconds = 4.0
            
            DispatchQueue.main.asyncAfter (deadline: .now () + timeInSeconds) { [weak self] in
                
                self?.recolorButton(text: "Перейти в корзину", bgColor: .accent, textColor: .white, lowerViewBgColor: .accentColorLight, lowerViewTextColor: .black)
                
            }

        } else if totalCost < onePurchaseLimit {
            performSegue(withIdentifier: "pupilDiningCartVCSegue", sender: self)
        } else {
            Vibration.error.vibrate()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pupilDiningCartVCSegue" {
            if let viewControllerB = segue.destination as? PupilDiningCartViewController {
                viewControllerB.cart = cart
                viewControllerB.totalCost = totalCost
                viewControllerB.onePurchaseLimit = onePurchaseLimit
                viewControllerB.dailyLimit = dailyLimit
                viewControllerB.spentToday = spentToday
            }
        }
    }
}

extension PupilDiningAddToCartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if foodTypeObjects[section] == .dough {
            return allowedDoughObjects.count
            
        } else if foodTypeObjects[section] == .beverage {
            return allowedBeverageObjects.count
            
        } else if foodTypeObjects[section] == .soup {
            return allowedSoupObjects.count
            
        } else if foodTypeObjects[section] == .meal {
            return allowedMealObjects.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerView = UIView()
        var view: FlexibleHeader?
        
        if foodTypeObjects[section] == .dough {
            
            view = FlexibleHeader.init(input: .init(firstComponent: "Выпечка", secondComponent: nil, thirdComponent: nil, isSmall: false))
            
        } else if foodTypeObjects[section] == .beverage {
            
            view = FlexibleHeader.init(input: .init(firstComponent: "Напитки", secondComponent: nil, thirdComponent: nil, isSmall: false))
            
        } else if foodTypeObjects[section] == .soup {
            
            view = FlexibleHeader.init(input: .init(firstComponent: "Суп", secondComponent: nil, thirdComponent: nil, isSmall: false))
            
        } else if foodTypeObjects[section] == .meal {
            
            view = FlexibleHeader.init(input: .init(firstComponent: "Второе", secondComponent: nil, thirdComponent: nil, isSmall: false))
            
        }
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        
        if allowedDoughObjects.count > 0 {
            foodTypeObjects.append(.dough)
            count += 1
        }
        
        if allowedBeverageObjects.count > 0 {
            foodTypeObjects.append(.beverage)
            count += 1
        }
        
        if allowedSoupObjects.count > 0 {
            foodTypeObjects.append(.soup)
            count += 1
        }
        
        if allowedMealObjects.count > 0 {
            foodTypeObjects.append(.meal)
            count += 1
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlexibleTableViewCell.reuseIdentifier, for: indexPath) as! FlexibleTableViewCell
        
        var input: FlexibleTableViewCell.Input?
        
        if foodTypeObjects[indexPath.section] == .dough {
            
            input = .init(leftIcon: nil, title: .init(text: allowedDoughObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(allowedDoughObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(allowedDoughObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
            
        } else if foodTypeObjects[indexPath.section] == .beverage {
            
            input = .init(leftIcon: nil, title: .init(text: allowedBeverageObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(allowedBeverageObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(allowedBeverageObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
            
        } else if foodTypeObjects[indexPath.section] == .soup {
            
            input = .init(leftIcon: nil, title: .init(text: allowedSoupObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(allowedSoupObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(allowedSoupObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
            
        } else if foodTypeObjects[indexPath.section] == .meal {
            
            input = .init(leftIcon: nil, title: .init(text: allowedMealObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(allowedMealObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(allowedMealObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
            
        }
        
        cell.setup(input: input!)
        
        cell.removeClosure = { [weak self] in
            
            guard let strongSelf = self else { return }

            print("Tapped cell at indexPath: \(indexPath)")

            let foodTitleToDecrement = input?.title.text

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
                    
                    if strongSelf.totalCost < strongSelf.onePurchaseLimit {
                        strongSelf.recolorButton(text: "Перейти в корзину", bgColor: .accent, textColor: .white, lowerViewBgColor: .accentColorLight, lowerViewTextColor: .black)
                    }
    //                break
                }
                
            }
            
            strongSelf.totalCostLabel.text = "Итого: \(strongSelf.totalCost) ₸"

        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        if foodTypeObjects[indexPath.section] == .dough {
            
            if allowedDoughObjects[indexPath.row].count == 0 {
                cart.addedItems.append(allowedDoughObjects[indexPath.row])
            }
            doughObjects[indexPath.row].count += 1
            
            totalCost += allowedDoughObjects[indexPath.row].price
            
        } else if foodTypeObjects[indexPath.section] == .beverage {
            
            if allowedBeverageObjects[indexPath.row].count == 0 {
                cart.addedItems.append(allowedBeverageObjects[indexPath.row])
            }
            allowedBeverageObjects[indexPath.row].count += 1

            totalCost += allowedBeverageObjects[indexPath.row].price

        } else if foodTypeObjects[indexPath.section] == .soup {
            
            if allowedSoupObjects[indexPath.row].count == 0 {
                cart.addedItems.append(allowedSoupObjects[indexPath.row])
            }
            allowedSoupObjects[indexPath.row].count += 1

            totalCost += allowedSoupObjects[indexPath.row].price

        } else if foodTypeObjects[indexPath.section] == .meal {
            
            if allowedMealObjects[indexPath.row].count == 0 {
                cart.addedItems.append(allowedMealObjects[indexPath.row])
            }
            allowedMealObjects[indexPath.row].count += 1

            totalCost += allowedMealObjects[indexPath.row].price

        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        totalCostLabel.text = "Итого: \(totalCost) ₸"
        detailsLabel.text = "Лимит разовой покупки: \(onePurchaseLimit) ₸\nЛимит на день: \(dailyLimit) ₸\nОсталось на день: \(dailyLimit - spentToday) ₸"
        
        if totalCost > onePurchaseLimit {
            lowerView.backgroundColor = Colors.danger100.color
            totalCostLabel.textColor = Colors.danger500.color
            detailsLabel.textColor = Colors.danger500.color
            goToCartButton.backgroundColor = Colors.danger500.color
            goToCartButton.setTitleColor(.white, for: .normal)
            goToCartButton.setTitle("Превышен лимит", for: .normal)
        }

    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 58
//    }
}

extension PupilDiningAddToCartViewController: FlexibleCellButtonDelegate {
    func buttonTapped(for cell: FlexibleCell) {
        print("cell = \(cell.titleLabel.text) \(cell.secondComponentLabel?.text)")
    }

    func buttonTapped(indexPath: IndexPath) {
        print("indexpath = \(indexPath)")
    }
}
