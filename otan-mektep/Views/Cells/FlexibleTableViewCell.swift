//
//  FlexibleTableViewCell.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 03.01.2024.
//

import UIKit

extension FlexibleTableViewCell: FlexibleCellButtonDelegate {
    func buttonTapped(indexPath: IndexPath) {
        delegate?.buttonTapped(indexPath: indexPath)
    }
}

class FlexibleTableViewCell: UITableViewCell {
    
    static let id = "FlexibleTableViewCell"
    private var flexibleCell: FlexibleCell?
    
    var delegate: FlexibleCellButtonDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupUI()
    }
    
    private func setupUI() {
        self.isUserInteractionEnabled = true
        self.selectionStyle = .default
        
        flexibleCell?.delegate = self

        contentView.addSubview(flexibleCell!)
        flexibleCell!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flexibleCell!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            flexibleCell!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            flexibleCell!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            flexibleCell!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
    
    func configure(with input: FlexibleCell.Input) {
         // Check if the cell is already created
         if flexibleCell?.superview != nil {
             // Update the existing cell's content
             flexibleCell?.configure(with: input)
         } else {
             // Cell is not yet created, create and configure it
             flexibleCell = FlexibleCell(input: input)
             setupUI()
         }
     }
}
