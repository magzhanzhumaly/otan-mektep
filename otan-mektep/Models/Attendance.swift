//
//  Attendance.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 08.01.2024.
//


import Foundation

class PupilHistory {
    let date: Date
    let cameAt: Date?
    let leftAt: Date?
    var itemsPurchased: [FoodObject]?
    var moneySpent: Int?
    
    
    init(date: Date, cameAt: Date?, leftAt: Date?, itemsPurchased: [FoodObject]?, moneySpent: Int?) {
        self.date = date
        self.cameAt = cameAt
        self.leftAt = leftAt
        self.itemsPurchased = itemsPurchased
        self.moneySpent = moneySpent
    }
}

let currentDate = Date()

// Create a Calendar instance
let calendar = Calendar.current
let rightNow = Date()
var daysShifted = 0

func returnDay(daysBefore: Int) -> Date {
    let result = calendar.date(byAdding: .day, value: -daysBefore, to: rightNow)
    
    return result ?? Date()
}

func returnDay(day: Int, month: Int, year: Int) -> Date {
    let dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day)
    let composedDate = calendar.date(from: dateComponents)
    
    return composedDate ?? Date()
}

func returnTime(day: Int, month: Int, year: Int, hour: Int, minute: Int) -> Date {
    let timeComponents = DateComponents(calendar: calendar, year: year, month: month, day: day, hour: hour, minute: minute)
    let composedTime = calendar.date(from: timeComponents)
    
    return composedTime ?? Date()
}

func returnTime(date: Date, hour: Int?, minute: Int?) -> Date {
    let pulledComponents = calendar.dateComponents([.day, .month, .year], from: date)
    
    let timeComponents = DateComponents(calendar: calendar, year: pulledComponents.year, month: pulledComponents.month, day: pulledComponents.day, hour: hour, minute: minute)
    let composedTime = calendar.date(from: timeComponents)
    
    return composedTime ?? Date()
}

var pupilHistory: [PupilHistory] = [.init(date: returnDay(daysBefore: 0),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),

                                    .init(date: returnDay(daysBefore: 3),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: nil, minute: nil),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 4),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 5),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 8, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 6),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 0),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 1),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 12),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 35),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 2),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 8, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 13, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 7),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 8),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 9),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 10),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 11),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 12),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 13),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 14),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 15),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 16),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 17),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 18),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 19),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 20),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 21),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 22),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 23),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 24),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 25),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 26),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 27),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 28),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 29),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 30),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 31),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 32),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 33),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 34),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 35),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 36),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 38),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(daysBefore: 39),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    
                                    
                                    
//                                    november
                                    .init(date: returnDay(daysBefore: 40),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(day: 29, month: 11, year: 2023),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(day: 28, month: 11, year: 2023),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    

                                    
//                                    november

                                    .init(date: returnDay(day: 2, month: 10, year: 2023),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
                                    .init(date: returnDay(day: 9, month: 10, year: 2023),
                                          cameAt: returnTime(date: returnDay(daysBefore: 0), hour: 9, minute: 31),
                                          leftAt: returnTime(date: returnDay(daysBefore: 0), hour: 12, minute: 31),
                                          itemsPurchased: nil,
                                          moneySpent: nil),
//
                                    


]

