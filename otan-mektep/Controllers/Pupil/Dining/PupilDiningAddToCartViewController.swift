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

    class FoodObject {
        let foodTitle: String
        let price: Int
        var count: Int
        let type: FoodTypes
        
        init(foodTitle: String, price: Int, count: Int, type: FoodTypes) {
            self.foodTitle = foodTitle
            self.price = price
            self.count = count
            self.type = type
        }
        
        init(foodTitle: String, price: Int, type: FoodTypes) {
            self.foodTitle = foodTitle
            self.price = price
            self.count = 0
            self.type = type
        }
    }
    
    enum FoodTypes {
        case dough
        case beverage
        case soup
        case meal
    }
    
    struct Cart {
        var addedItems: [FoodObject]
    }
    
    var cart = Cart(addedItems: .init())

    var foodTypeObjects = [FoodTypes]()
    
    var doughObjects: [FoodObject] = [.init(foodTitle: "Сосика в тесте",
                                           price: 150,
                                           type: .dough),
                                     .init(foodTitle: "Пицца",
                                           price: 250,
                                           type: .dough),
                                      .init(foodTitle: "Булочка",
                                            price: 150,
                                            type: .dough),
                                      .init(foodTitle: "Учпучмак",
                                            price: 200,
                                            type: .dough),
                                      .init(foodTitle: "Самса с сыром",
                                            price: 260,
                                            type: .dough)]
    
    var beverageObjects: [FoodObject] = [.init(foodTitle: "Fuse чай",
                                               price: 150,
                                               type: .beverage),
                                         .init(foodTitle: "Maxi чай",
                                               price: 250,
                                               type: .dough),
                                         .init(foodTitle: "Вода",
                                               price: 100,
                                               type: .dough)]
 
    var soupObjects: [FoodObject] = [.init(foodTitle: "Щи",
                                           price: 1000,
                                           type: .beverage),
                                     .init(foodTitle: "Борщ",
                                           price: 1100,
                                           type: .beverage),
                                      .init(foodTitle: "Суп с курицей",
                                            price: 900,
                                            type: .beverage)]
    
    var mealObjects: [FoodObject] = [.init(foodTitle: "Плов",
                                           price: 1200,
                                           type: .meal),
                                     .init(foodTitle: "Лагман",
                                           price: 1300,
                                           type: .meal),
                                      .init(foodTitle: "Котлеты с гречкой",
                                            price: 1000,
                                            type: .meal)]
    
    
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
        
        tableView.register(UINib(nibName: FlexibleTableViewCell.id, bundle: nil), forCellReuseIdentifier: FlexibleTableViewCell.id)

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
    

    @objc func goToCart() {
        if totalCost < onePurchaseLimit {
            performSegue(withIdentifier: "pupilDiningCartVCSegue", sender: self)
        } else {
            Vibration.error.vibrate()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
    }
}

extension PupilDiningAddToCartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if foodTypeObjects[section] == .dough {
            return doughObjects.count
            
        } else if foodTypeObjects[section] == .beverage {
            return beverageObjects.count
            
        } else if foodTypeObjects[section] == .soup {
            return soupObjects.count
            
        } else if foodTypeObjects[section] == .meal {
            return mealObjects.count
            
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
        
        if doughObjects.count > 0 {
            foodTypeObjects.append(.dough)
            count += 1
        }
        
        if beverageObjects.count > 0 {
            foodTypeObjects.append(.beverage)
            count += 1
        }
        
        if soupObjects.count > 0 {
            foodTypeObjects.append(.soup)
            count += 1
        }
        
        if mealObjects.count > 0 {
            foodTypeObjects.append(.meal)
            count += 1
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlexibleTableViewCell.id, for: indexPath) as! FlexibleTableViewCell
        
        var input: FlexibleCell.Input?
        
        if foodTypeObjects[indexPath.section] == .dough {
            input = .init(leftIcon: nil, title: .init(text: doughObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(doughObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(doughObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
        } else if foodTypeObjects[indexPath.section] == .beverage {
            input = .init(leftIcon: nil, title: .init(text: beverageObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(beverageObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(beverageObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
        } else if foodTypeObjects[indexPath.section] == .soup {
            input = .init(leftIcon: nil, title: .init(text: soupObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(soupObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(soupObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
        } else if foodTypeObjects[indexPath.section] == .meal {
            input = .init(leftIcon: nil, title: .init(text: mealObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(mealObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(mealObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
        }
        
        cell.delegate = self
        cell.configure(with: input!) // Use the existing cell and configure it
                
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        if foodTypeObjects[indexPath.section] == .dough {
            
            if doughObjects[indexPath.row].count == 0 {
                cart.addedItems.append(doughObjects[indexPath.row])
            }
            doughObjects[indexPath.row].count += 1
            
            totalCost += doughObjects[indexPath.row].price
            
        } else if foodTypeObjects[indexPath.section] == .beverage {
            
            if beverageObjects[indexPath.row].count == 0 {
                cart.addedItems.append(beverageObjects[indexPath.row])
            }
            beverageObjects[indexPath.row].count += 1

            totalCost += beverageObjects[indexPath.row].price

        } else if foodTypeObjects[indexPath.section] == .soup {
            
            if soupObjects[indexPath.row].count == 0 {
                cart.addedItems.append(soupObjects[indexPath.row])
            }
            soupObjects[indexPath.row].count += 1

            totalCost += soupObjects[indexPath.row].price

        } else if foodTypeObjects[indexPath.section] == .meal {
            
            if mealObjects[indexPath.row].count == 0 {
                cart.addedItems.append(mealObjects[indexPath.row])
            }
            mealObjects[indexPath.row].count += 1

            totalCost += mealObjects[indexPath.row].price

        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        totalCostLabel.text = "Итого: \(totalCost)₸"
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
}

extension PupilDiningAddToCartViewController: FlexibleCellButtonDelegate {
    func buttonTapped(for cell: FlexibleCell) {
        print("cell = \(cell.titleLabel.text) \(cell.secondComponentLabel?.text)")
//        print("indexpath = \(cell.input?.indexPath)")

    }
    
    
    func buttonTapped(indexPath: IndexPath) {
        print("indexpath = \(indexPath)")
        
        /*
        if foodTypeObjects[indexPath.section] == .dough {
            
            if doughObjects[indexPath.row].count > 0 {
                doughObjects[indexPath.row].count -= 1
                
                if doughObjects[indexPath.row].count == 0 {
                    let foodTitleToRemove = doughObjects[indexPath.row].foodTitle
                    cart.addedItems = cart.addedItems.filter { $0.foodTitle != foodTitleToRemove }
                }
            }
            
        } else if foodTypeObjects[indexPath.section] == .beverage {
            
            if beverageObjects[indexPath.row].count > 0 {
                beverageObjects[indexPath.row].count += 1
                
                if beverageObjects[indexPath.row].count == 0 {
                    let foodTitleToRemove = beverageObjects[indexPath.row].foodTitle
                    cart.addedItems = cart.addedItems.filter { $0.foodTitle != foodTitleToRemove }
                }
            }
            
        } else if foodTypeObjects[indexPath.section] == .soup {
            
            if soupObjects[indexPath.row].count > 0 {
                soupObjects[indexPath.row].count += 1
                
                if soupObjects[indexPath.row].count == 0 {
                    let foodTitleToRemove = soupObjects[indexPath.row].foodTitle
                    cart.addedItems = cart.addedItems.filter { $0.foodTitle != foodTitleToRemove }
                }
            }
            
        } else if foodTypeObjects[indexPath.section] == .meal {
            
            if mealObjects[indexPath.row].count > 0 {
                mealObjects[indexPath.row].count += 1
                
                if mealObjects[indexPath.row].count == 0 {
                    let foodTitleToRemove = mealObjects[indexPath.row].foodTitle
                    cart.addedItems = cart.addedItems.filter { $0.foodTitle != foodTitleToRemove }
                }
            }
            
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
         */
    }
    
}
