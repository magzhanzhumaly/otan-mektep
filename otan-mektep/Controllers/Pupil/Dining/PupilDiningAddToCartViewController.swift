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
    
    var cart = Cart(addedItems: .init())
    
    var totalCost = 550
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
        
        let totalCostLabel = UILabel()
        let detailsLabel = UILabel()
        let goToCartButton = UIButton()
        let lowerView = UIView()
        
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
        performSegue(withIdentifier: "pupilDiningCartVCSegue", sender: self)
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
            input = .init(leftIcon: nil, title: .init(text: doughObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(doughObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(doughObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: { [weak self] in
                
                print("indexpath = \(indexPath)")
//                if self?.doughObjects[indexPath.row].count == 0 {
//                    self?.cart.addedItems.append(self?.doughObjects[indexPath.row] ?? .init(foodTitle: "", price: 0, type: .dough))
//                }
//                
//                self?.doughObjects[indexPath.row].count += 1
//                print("\tcart = ")
////                print("\tcart = \(String(describing: self?.cart.addedItems))")
//                for food in self!.cart.addedItems {
//                    print("\(food.foodTitle) \(food.count) штук")
//                }
//
//                tableView.reloadRows(at: [indexPath], with: .automatic)

            }, indexPath: indexPath)
        } else if foodTypeObjects[indexPath.section] == .beverage {
            input = .init(leftIcon: nil, title: .init(text: beverageObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(beverageObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(beverageObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: { [weak self] in
                
                print("indexpath = \(indexPath)")

//                if self?.beverageObjects[indexPath.row].count == 0 {
//                    self?.cart.addedItems.append(self?.beverageObjects[indexPath.row] ?? .init(foodTitle: "", price: 0, type: .dough))
//                }
//                self?.beverageObjects[indexPath.row].count += 1
//                print("cart = \(String(describing: self?.cart))")
//                tableView.reloadRows(at: [indexPath], with: .automatic)

            }, indexPath: indexPath)
        } else if foodTypeObjects[indexPath.section] == .soup {
            input = .init(leftIcon: nil, title: .init(text: soupObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(soupObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(soupObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: { [weak self] in
                
                print("indexpath = \(indexPath)")

//                if self?.soupObjects[indexPath.row].count == 0 {
//                    self?.cart.addedItems.append(self?.soupObjects[indexPath.row] ?? .init(foodTitle: "", price: 0, type: .dough))
//                }
//                
//                self?.soupObjects[indexPath.row].count += 1
//                print("cart = \(String(describing: self?.cart))")
//                tableView.reloadRows(at: [indexPath], with: .automatic)

            }, indexPath: indexPath)
        } else if foodTypeObjects[indexPath.section] == .meal {
            input = .init(leftIcon: nil, title: .init(text: mealObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(mealObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(mealObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: { [weak self] in
                
                print("indexpath = \(indexPath)")

//                if self?.mealObjects[indexPath.row].count == 0 {
//                    self?.cart.addedItems.append(self?.mealObjects[indexPath.row] ?? .init(foodTitle: "", price: 0, type: .dough))
//                }
//                self?.mealObjects[indexPath.row].count += 1
//                print("cart = \(String(describing: self?.cart))")
//                tableView.reloadRows(at: [indexPath], with: .automatic)

            }, indexPath: indexPath)
        }
        
        cell.delegate = self
        cell.configure(with: input!) // Use the existing cell and configure it
        
//        cell.selectionStyle = .none
        
        return cell
        
        
    }/*
      
      var input: FlexibleCell.Input?
      
      if foodTypeObjects[indexPath.section] == .dough {
      
      input = .init(leftIcon: nil, title: .init(text: doughObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(doughObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(doughObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {})
      
      } else if foodTypeObjects[indexPath.section] == .beverage {
      
      input = .init(leftIcon: nil, title: .init(text: beverageObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(beverageObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(beverageObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {})
      
      } else if foodTypeObjects[indexPath.section] == .soup {
      
      input = .init(leftIcon: nil, title: .init(text: soupObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(soupObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(soupObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {})
      
      } else if foodTypeObjects[indexPath.section] == .meal {
      
      input = .init(leftIcon: nil, title: .init(text: mealObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(mealObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(mealObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {})
      
      }
      
      let view = FlexibleCell(input: input!)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FlexibleTableViewCell.id, for: indexPath) as! FlexibleTableViewCell
        
        cell.contentView.addSubview(view)
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
            view.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0),
        ])
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(indexPath)
        
        if foodTypeObjects[indexPath.section] == .dough {
            
            doughObjects[indexPath.row].count += 1
            
        } else if foodTypeObjects[indexPath.section] == .beverage {
            
            beverageObjects[indexPath.row].count += 1

        } else if foodTypeObjects[indexPath.section] == .soup {
            
            soupObjects[indexPath.row].count += 1

        } else if foodTypeObjects[indexPath.section] == .meal {
            
            mealObjects[indexPath.row].count += 1

        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
}

extension PupilDiningAddToCartViewController: FlexibleCellButtonDelegate {
    
    func buttonTapped(indexPath: IndexPath) {
        if foodTypeObjects[indexPath.section] == .dough {
            
            if doughObjects[indexPath.row].count > 0 {
                doughObjects[indexPath.row].count -= 1
            }
            
        } else if foodTypeObjects[indexPath.section] == .beverage {
            
            if beverageObjects[indexPath.row].count > 0 {
                beverageObjects[indexPath.row].count += 1
            }
        } else if foodTypeObjects[indexPath.section] == .soup {
            
            if soupObjects[indexPath.row].count > 0 {
                soupObjects[indexPath.row].count += 1
            }
            
        } else if foodTypeObjects[indexPath.section] == .meal {
            
            if mealObjects[indexPath.row].count > 0 {
                mealObjects[indexPath.row].count += 1
            }
            
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
