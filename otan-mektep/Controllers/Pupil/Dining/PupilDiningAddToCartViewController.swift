//
//  PupilDiningAddToCartViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit

class PupilDiningAddToCartViewController: UIViewController, FlexibleCellButtonDelegate {
    
    func buttonTapped() {
        print("heyte")
    }
    
    @IBOutlet weak var itogoLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var lowerView: UIView!
    
    struct FoodObject {
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
    
    var cart = [FoodObject]()
    var totalCost = 0

    func onCancel() {
        AppUtility.onCancel(self, true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var cart = Cart(addedItems: .init())
        
        tableView.separatorStyle = .none
        
        lowerView.backgroundColor = .accentColorLight
          tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.backgroundColor = .yellow
        let nav = Navigation.title("Выбор еды",
                                   large: false,
                                   leftAction: [.init(nil, UIImage(named: "arrow-left-large"), false, { [weak self] in })],
                                   rightAction: [.init(nil, nil, false, nil)])
    
        
        let topBar = AcadlyNavigation(style: nav, searchInfo: nil)
        
        buttonContainer.addFilledSubview(OtanMektepButton(input: .init(isLarge: true, isFilled: true, text: "Перейти в корзину", color: nil, closure: nil))) //(input: .init(isLarge: true, isFilled: true, text: "Перейти в корзину"), color: nil, closure: nil))
//        topBarContainer.addFilledSubview(topBar)
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        let cell = UITableViewCell()
        
        var view: FlexibleCell?
        if foodTypeObjects[indexPath.section] == .dough {
            
            view = FlexibleCell(input: .init(leftIcon: nil, title: .init(text: doughObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(doughObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(doughObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}))
            
        } else if foodTypeObjects[indexPath.section] == .beverage {
            
            view = FlexibleCell(input: .init(leftIcon: nil, title: .init(text: beverageObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(beverageObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(beverageObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}))

        } else if foodTypeObjects[indexPath.section] == .soup {
            
            view = FlexibleCell(input: .init(leftIcon: nil, title: .init(text: soupObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(soupObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(soupObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}))

        } else if foodTypeObjects[indexPath.section] == .meal {
            
            view = FlexibleCell(input: .init(leftIcon: nil, title: .init(text: mealObjects[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(mealObjects[indexPath.row].price) ₸", lowerText: "Выбрано: \(mealObjects[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}))
            
        }
        
        view?.delegate = self
    
        cell.addSubview(view!)
        view?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20),
            view!.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20),
            view!.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0),
            view!.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0),
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
