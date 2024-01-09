//
//  PupilDiningHistoryViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit

class PupilDiningHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewNavigatorContainer: UIView!
    
    
    var currentPage = 1
    let navigator = TableViewNavigator.init(currentPage: 1, totalPageCount: 3)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FlexibleTableViewCell.self, forCellReuseIdentifier: FlexibleTableViewCell.reuseIdentifier)

//        tableView.backgroundColor = .gray50
        
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
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1),

            tableViewNavigatorContainer.bottomAnchor.constraint(equalTo: bottomSeparator.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
                
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        navigator.delegate = self
        
        tableViewNavigatorContainer.addFilledSubview(navigator)

    }
    
    var sortedAttendance: [(Date, [PupilHistory])] = []


}

extension PupilDiningHistoryViewController: TableViewNavigatorDelegate {
    
    func previousTapped(currentPage: Int, totalPageCount: Int) {
        if self.currentPage <= 1 {
            self.currentPage = 1
        } else {
            self.currentPage -= 1
        }
        
        navigator.changePage(to: self.currentPage)
    }
    
    func nextTapped(currentPage: Int, totalPageCount: Int) {
        if self.currentPage >= totalPageCount {
            self.currentPage = totalPageCount
        } else {
            self.currentPage += 1
        }
        
        navigator.changePage(to: self.currentPage)
    }
    
    
}

extension PupilDiningHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Function to group attendance data by month
    private func groupAttendanceByMonth() -> [(Date, [PupilHistory])] {
//        var groupedAttendance: [Date: [PupilHistory]] = [:]
//        
//        for attendance in pupilHistory {
//            let monthStart = Calendar.current.startOfDay(for: attendance.date)
//            groupedAttendance[monthStart, default: []].append(attendance)
//        }
//        
//        return groupedAttendance
        /*
        var groupedAttendance: [Date: [PupilHistory]] = [:]
        
        for attendance in pupilHistory {
            let monthStart = Calendar.current.startOfDay(for: attendance.date)
            groupedAttendance[monthStart, default: []].append(attendance)
        }
        
        // Sort the groupedAttendance dictionary by keys (dates) in descending order
        let sortedGroups = groupedAttendance.sorted { $0.key > $1.key }
        
        // Create a new dictionary with the sorted groups
        var sortedAttendance: [Date: [PupilHistory]] = [:]
        for (date, history) in sortedGroups {
            sortedAttendance[date] = history
        }
        
        return sortedAttendance*/
        
        /*
        var groupedAttendance: [Date: [PupilHistory]] = [:]
            
            for attendance in pupilHistory {
                let components = Calendar.current.dateComponents([.year, .month], from: attendance.date)
                let monthStart = Calendar.current.date(from: components)!
                groupedAttendance[monthStart, default: []].append(attendance)
            }
            
            // Sort the groupedAttendance dictionary by keys (dates) in descending order
            let sortedGroups = groupedAttendance.sorted { $0.key > $1.key }
            
            // Create a new dictionary with the sorted groups
            var sortedAttendance: [Date: [PupilHistory]] = [:]
            for (date, history) in sortedGroups {
                sortedAttendance[date] = history
            }
            
            return sortedAttendance

         */
//        var groupedAttendance: [Date: [PupilHistory]] = [:]
//        
//        for attendance in pupilHistory {
//            let components = Calendar.current.dateComponents([.year, .month], from: attendance.date)
//            let monthStart = Calendar.current.date(from: components)!
//            groupedAttendance[monthStart, default: []].append(attendance)
//        }
//        
//        // Sort the groupedAttendance dictionary by keys (dates) in descending order
//        let sortedGroups = groupedAttendance.sorted { $0.key > $1.key }
//        
//        // Create a new dictionary with the sorted groups
//        var sortedAttendance: [Date: [PupilHistory]] = [:]
//        for (date, history) in sortedGroups {
//            sortedAttendance[date] = history
//        }
//        print("at")
//
//        for at in sortedAttendance {
//            print("\(at.key)  \(at.value)")
//        }
//        print("at")
//
//        return sortedAttendance
        
//        var groupedAttendance: [Date: [PupilHistory]] = [:]
//        
//        for attendance in pupilHistory {
//            let components = Calendar.current.dateComponents([.year, .month], from: attendance.date)
//            let monthStart = Calendar.current.date(from: components)!
//            groupedAttendance[monthStart, default: []].append(attendance)
//        }
//        
//        // Sort the groupedAttendance dictionary by keys (dates) in descending order
//        let sortedGroups = groupedAttendance.sorted { $0.key > $1.key }
//        
//        // Convert the sortedGroups dictionary to an array of tuples
//        let sortedAttendance: [(Date, [PupilHistory])] = sortedGroups.map { (date, history) in
//            return (date, history)
//        }
//        self.sortedAttendance = sortedAttendance
//        
//        return sortedAttendance

        
        var groupedAttendance: [Date: [PupilHistory]] = [:]
        
        for attendance in pupilHistory {
            let components = Calendar.current.dateComponents([.year, .month], from: attendance.date)
            let monthStart = Calendar.current.date(from: components)!
            groupedAttendance[monthStart, default: []].append(attendance)
        }
        
        // Sort the groupedAttendance dictionary by keys (dates) in descending order
        let sortedGroups = groupedAttendance.sorted { $0.key > $1.key }

        // Sort the days within each month in descending order
        for (date, history) in sortedGroups {
            groupedAttendance[date] = history.sorted(by: { $0.date > $1.date })
        }

        // Create a new array of tuples with the sorted groups
        let sortedAttendance: [(Date, [PupilHistory])] = groupedAttendance.sorted { $0.key > $1.key }

        self.sortedAttendance = sortedAttendance
        return sortedAttendance
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupAttendanceByMonth().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedAttendance[section].1.count ?? 0

//        let groupedAttendance = groupAttendanceByMonth()
//        let monthKey = Array(groupedAttendance.keys.sorted())[section]
//        return groupedAttendance[monthKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlexibleTableViewCell.reuseIdentifier, for: indexPath) as! FlexibleTableViewCell
        
        var input: FlexibleTableViewCell.Input?
        
        
        let groupedAttendance = groupAttendanceByMonth()
//        let monthKey = Array(groupedAttendance.keys.sorted())[indexPath.section]
//        if let attendance = groupedAttendance[monthKey]?[indexPath.row] {
            let attendance = sortedAttendance[indexPath.section].1[indexPath.row]

            input = .init(leftIcon: nil,
                          title: .init(text: formatDate(attendance.date),
                                       isBold: false,
                                       isLarge: true),
                          components: .init(input:
                                .title(text: .init(text: formatTime(attendance.cameAt).0,
                                                   isBold: false,
                                                   isLarge: false)),
                                            color: formatTime(attendance.cameAt).1),
                          corners: .init(isRounded: false),
                          closure: {},
                          indexPath: indexPath)
            
            
            cell.setup(input: input!)
        
        
        
        cell.backgroundColor = .gray50
        return cell
    }
    
    func formatDate(_ date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "d MMMM yyyy"
            return dateFormatter.string(from: date)
        } else {
            return "Нет информации"
        }
    }
    
    func formatTime(_ date: Date?) -> (String, UIColor) {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Using a neutral locale for consistent formatting
            dateFormatter.dateFormat = "H:mm"
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: date)

            if let hour = components.hour, let minute = components.minute {
                if hour == 9 && minute > 30 {
                    return (dateFormatter.string(from: date), .warning500)
                } else {
                    return (dateFormatter.string(from: date), .success500)
                }
            }
        }
        return ("Нет информации", .primary500)
    }
    
    func formatDateHeader(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "LLLL yyyy"
        return dateFormatter.string(from: date).capitalized
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let groupedAttendance = groupAttendanceByMonth()
//        let sortedDates = Array(groupedAttendance.keys.sorted { $0 > $1 })
//        
//        guard section < sortedDates.count else { return nil }
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "LLLL yyyy"
//        
//        return dateFormatter.string(from: sortedDates[section])
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        var view: FlexibleHeader?
        
        
        let groupedAttendance = groupAttendanceByMonth()
//        let monthKey = Array(groupedAttendance.keys.sorted())[section]
//        headerLabel.text =

        view = FlexibleHeader.init(input: .init(firstComponent: formatDateHeader(sortedAttendance[section].0), secondComponent: nil, thirdComponent: nil, isSmall: false))

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

}
