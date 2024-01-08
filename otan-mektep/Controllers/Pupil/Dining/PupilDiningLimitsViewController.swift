//
//  PupilDiningLimitsViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit

class PupilDiningLimitsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var totalCost = 0
    var onePurchaseLimit = 1000
    var dailyLimit = 3000
    var spentToday = 1800
    
    let limitsLabel = UILabel()
    let detailsLabel = UILabel()
    let buttonContainer = UIView()
    let lowerView = UIView()

    let limitedFood: [FoodObject] = []
    
    
    /*
     
     let allowedDoughObjects = doughObjects.filter { doughObject in
         !limitedFoods.limitedItems.contains { $0.foodTitle == doughObject.foodTitle }
     }

     let allowedBeverageObjects = doughObjects.filter { beverageObject in
         !limitedFoods.limitedItems.contains { $0.foodTitle == beverageObject.foodTitle }
     }

     let allowedSoupObjects = doughObjects.filter { soupObject in
         !limitedFoods.limitedItems.contains { $0.foodTitle == soupObject.foodTitle }
     }

     let allowedMealObjects = doughObjects.filter { mealObject in
         !limitedFoods.limitedItems.contains { $0.foodTitle == mealObject.foodTitle }
     }

     */
    
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
        limitsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lowerView)
        lowerView.addSubview(limitsLabel)
        lowerView.addSubview(detailsLabel)
        
        limitsLabel.text = "Лимиты затрат"

        detailsLabel.text = "Лимит разовой покупки: \(onePurchaseLimit) ₸\nЛимит на день: \(dailyLimit) ₸\nОсталось на день: \(dailyLimit - spentToday) ₸"

        limitsLabel.font = Fonts.title2Bold22.font
        detailsLabel.font = Fonts.caption1Regular12.font
        
        detailsLabel.numberOfLines = 0
        limitsLabel.numberOfLines = 0
        
        detailsLabel.textAlignment = .left
        
        
        NSLayoutConstraint.activate([
            lowerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lowerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lowerView.bottomAnchor.constraint(equalTo: bottomSeparator.topAnchor),
            lowerView.heightAnchor.constraint(equalToConstant: 140),
                    
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: lowerView.topAnchor),
            
            
            limitsLabel.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 23),
            limitsLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            
            detailsLabel.topAnchor.constraint(equalTo: limitsLabel.bottomAnchor, constant: 22),
            detailsLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
        ])
                
        tableView.separatorStyle = .none
                
        lowerView.backgroundColor = .accentColorLight
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

}

extension PupilDiningLimitsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return limitedFoods.limitedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlexibleTableViewCell.reuseIdentifier, for: indexPath) as! FlexibleTableViewCell
        
        let input: FlexibleTableViewCell.Input = .init(leftIcon: nil, title: .init(text: limitedFoods.limitedItems[indexPath.row].foodTitle, isBold: false, isLarge: true), components: .init(input: .twoVerticalLabels(upperText: "Цена: \(limitedFoods.limitedItems[indexPath.row].price) ₸", lowerText: "Выбрано: \(limitedFoods.limitedItems[indexPath.row].count)"), color: nil), corners: .init(isRounded: false), closure: {}, indexPath: indexPath)
            
        
        cell.setup(input: input)
        
        cell.removeClosure = { [weak self] in
            
            guard let strongSelf = self else { return }

            print("Tapped cell at indexPath: \(indexPath)")

            let foodTitleToDecrement = input.title.text

            print("----- CART ----- tapped \(String(describing: foodTitleToDecrement))")
            for food in limitedFoods.limitedItems {
                
                if food.foodTitle != foodTitleToDecrement {
                    print("\(food.count) \(food.foodTitle), \(food.price) тг")
                } else {
                    print("\(food.count - 1) \(food.foodTitle), \(food.price) тг")
                    
                    food.count -= 1
                    strongSelf.totalCost -= food.price
                    
                    cell.changeChosenCount(newNum: food.count)
                    
                    if food.count == 0 {
                        cell.removeButton?.isHidden = true
                        
                        limitedFoods.limitedItems = limitedFoods.limitedItems.filter{$0.foodTitle != food.foodTitle}
                    }
                    
                    if limitedFoods.limitedItems.isEmpty {
                    }
                }
            }
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
