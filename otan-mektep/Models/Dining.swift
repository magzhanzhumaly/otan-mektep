//
//  Cart.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 08.01.2024.
//

import Foundation
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

class Cart {
    var addedItems: [FoodObject] = []
}


class LimitedFoods {
    var limitedItems: [FoodObject] = [.init(foodTitle: "Fuse чай",
                                            price: 150,
                                            type: .beverage),
                                      .init(foodTitle: "Maxi чай",
                                            price: 250,
                                            type: .dough)]}

var limitedFoods = LimitedFoods()

var cart = Cart()

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



//var allowedDoughObjects = doughObjects.filter({$0.foodTitle != self.limitedItems})


let allowedDoughObjects = doughObjects.filter { doughObject in
    !limitedFoods.limitedItems.contains { $0.foodTitle == doughObject.foodTitle }
}

let allowedBeverageObjects = beverageObjects.filter { beverageObject in
    !limitedFoods.limitedItems.contains { $0.foodTitle == beverageObject.foodTitle }
}

let allowedSoupObjects = soupObjects.filter { soupObject in
    !limitedFoods.limitedItems.contains { $0.foodTitle == soupObject.foodTitle }
}

let allowedMealObjects = mealObjects.filter { mealObject in
    !limitedFoods.limitedItems.contains { $0.foodTitle == mealObject.foodTitle }
}

func functione() -> Int {
    // Create a Calendar instance
    let calendar = Calendar.current

    // Get the current date
    let currentDate = Date()

    // Extract the month and year components
    let components = calendar.dateComponents([.year, .month], from: currentDate)

    // Set the date to the first day of March (next month)
    if let firstDayOfNextMonth = calendar.date(from: DateComponents(year: components.year, month: components.month! + 1, day: 1)) {
        // Subtract one day to get the last day of February
        if let lastDayOfFebruary = calendar.date(byAdding: .day, value: -1, to: firstDayOfNextMonth) {
            // Compare if the last day of February is the 28th or 29th
            if calendar.component(.day, from: lastDayOfFebruary) == 29 {
                print("February has 29 days (leap year)")
                return 29
            } else {
                print("February has 28 days")
                return 28
            }
        }
    } else {
        print("Error calculating the number of days in February")
    }
    return 28

}

let januaryDayCount = 31
let februaryDayCount = functione()
let marchDayCount = 31
let aprilDayCount = 30
let mayDayCount = 31
let juneDayCount = 30
let julyDayCount = 31
let augustDayCount = 31
let septemberDayCount = 30
let octoberDayCount = 31
let novemberDayCount = 30
let decemberDayCount = 31
