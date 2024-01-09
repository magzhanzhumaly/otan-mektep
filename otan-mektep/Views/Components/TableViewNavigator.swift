//
//  TableViewNavigator.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 08.01.2024.
//

import UIKit

protocol TableViewNavigatorDelegate {
    func previousTapped(currentPage: Int, totalPageCount: Int)
    func nextTapped(currentPage: Int, totalPageCount: Int)
}
    
class TableViewNavigator: UIView {

    public var delegate: TableViewNavigatorDelegate?

    private var currentPage = 1
    private var totalPageCount = 1

    private let label = UILabel()
    private let previousButton = UIButton()
    private let nextButton = UIButton()

    init(currentPage: Int, totalPageCount: Int) {
        super.init(frame: .zero)
        
        self.currentPage = currentPage
        self.totalPageCount = totalPageCount
        
        label.text = "\(currentPage) страница"
        label.textAlignment = .center
        
        label.font = Fonts.body17.font
        
        previousButton.setImage(UIImage(named: "IOS Iconsarrow-backNo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        nextButton.setImage(UIImage(named: "IOS Iconsarrow-forwardNo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        if currentPage == 1 {
            previousButton.tintColor = .inactive
        } else {
            previousButton.tintColor = .black
        }
        
        if currentPage == totalPageCount {
            nextButton.tintColor = .inactive
        } else {
            nextButton.tintColor = .black
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        stackView.spacing = 20
        
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(nextButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func changePage(to pageNumber: Int) {
        label.text = "\(pageNumber) страница"
        if pageNumber <= 1 {
            currentPage = 1
            previousButton.tintColor = .inactive
        } else {
            previousButton.tintColor = .black
        }
        
        if pageNumber >= totalPageCount {
            currentPage = pageNumber
            nextButton.tintColor = .inactive
        } else {
            nextButton.tintColor = .black
        }
    }
    
    @objc func previousButtonTapped() {
        delegate?.previousTapped(currentPage: currentPage, totalPageCount: totalPageCount)
    }
    
    @objc func nextButtonTapped() {
        delegate?.nextTapped(currentPage: currentPage, totalPageCount: totalPageCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
