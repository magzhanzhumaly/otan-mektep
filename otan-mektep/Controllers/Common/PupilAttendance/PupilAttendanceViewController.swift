//
//  PupilAttendanceViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit

class PupilAttendanceViewController: UIViewController {
    let tableView = UITableView()
    let tableViewNavigatorContainer = UIView()
    
    var sortedAttendance: [(Date, [PupilHistory])] = []
    
    var currentPage = 1
    let navigator = TableViewNavigator.init(currentPage: 1, totalPageCount: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupAttendanceByMonth()

        tableViewNavigatorContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewNavigatorContainer)
        
        
        tableView.register(FlexibleTableViewCell.self, forCellReuseIdentifier: FlexibleTableViewCell.reuseIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
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
            tableViewNavigatorContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewNavigatorContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewNavigatorContainer.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        let name = user?.email ?? ""
        
        let text = "Добро пожаловать,\n\(name)!"
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            label.heightAnchor.constraint(equalToConstant: 50+20), // fix!!
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        let secondLabel = UILabel()
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.text = "Ваша посещаемость"
        secondLabel.font = Fonts.title2Bold22.font
        
        view.addSubview(secondLabel)
        NSLayoutConstraint.activate([
            secondLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            secondLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            secondLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            secondLabel.heightAnchor.constraint(equalToConstant: 28),

            tableView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableViewNavigatorContainer.topAnchor),
        ])
        
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
                
        navigator.delegate = self
        
        tableViewNavigatorContainer.addFilledSubview(navigator)
        
        topSeparator.isHidden = true
    }
    
}

extension PupilAttendanceViewController: TableViewNavigatorDelegate {
    
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

extension PupilAttendanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Function to group attendance data by month
    private func groupAttendanceByMonth() {
        
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
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedAttendance.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedAttendance[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlexibleTableViewCell.reuseIdentifier, for: indexPath) as! FlexibleTableViewCell
        
        var input: FlexibleTableViewCell.Input?
        
        
        let attendance = sortedAttendance[indexPath.section].1[indexPath.row]
        
        let timeTupleCameAt = formatTime(attendance.cameAt)
        
        var timeTextCameAt = "Пришел в \(timeTupleCameAt.0)"
        
        if timeTupleCameAt.1 == .primary500 {
            timeTextCameAt = timeTupleCameAt.0
        }
        
        let timeTupleLeftAt = formatTime(attendance.leftAt)
        
        var timeTextLeftAt = "Ушел в \(timeTupleLeftAt.0)"
        
        if timeTupleLeftAt.1 == .primary500 {
            timeTextLeftAt = timeTupleLeftAt.0
        }
        
        
        input = .init(leftIcon: nil,
                      title: .init(text: formatDate(attendance.date),
                                   isBold: false,
                                   isLarge: true),
                      components: .init(input: .twoVerticalLabels(upperText: timeTextCameAt, lowerText: timeTextLeftAt), color: timeTupleCameAt.1),
               
                      corners: .init(isRounded: false),
                      closure: {},
                      indexPath: indexPath)
        
        
        cell.setup(input: input!)
        cell.removeButton?.isHidden = true
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        var view: FlexibleHeader?
        
        view = FlexibleHeader.init(input: .init(firstComponent: formatDateHeader(sortedAttendance[section].0), secondComponent: nil, thirdComponent: nil, isSmall: false))
        
        containerView.addSubview(view!)
        view!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view!.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            view!.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            view!.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            view!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ])
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



