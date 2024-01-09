//
//  FlexibleTableViewCell.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 03.01.2024.
//
/*
import UIKit

extension FlexibleTableViewCell: FlexibleCellButtonDelegate {
    func buttonTapped(for cell: FlexibleCell) {
//        delegate?.buttonTapped(FlexibleCell)
//        if let indexPath = cell.input?.indexPath {
//            // Call your delegate method or perform other actions
            delegate?.buttonTapped(for: cell)
//        }
    }
    
//    @objc func removeAction() {
//        delegate?.buttonTapped(for: self)
//    }
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
*/



//
//  FlexibleCell.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 27.12.2023.
//

import UIKit

protocol FlexibleTableViewCellButtonDelegate: AnyObject {
    func buttonTapped(for cell: FlexibleTableViewCell)
}

class FlexibleTableViewCell: UITableViewCell {

    var removeClosure: (() -> ())?
    
    struct Input {
        let leftIcon: leftIconInput?
        let title: TextInput
        let components: Components?
        let corners: CornerInput?
        let closure: (() -> Void)?
        let indexPath: IndexPath
    }
    
    struct CornerInput {
        let isRounded: Bool
    }
    
    // MARK: textInput
    
    struct TextInput {
        let text: String
        let isBold: Bool
        let isLarge: Bool
    }
    
    // MARK: LeftIconInput
    
    struct leftIconInput {
        static let nextIcon = UIImage(named: "star_chip_icon")
        static let tickIcon = UIImage(named: "star_chip_icon")
        static let crossIcon = UIImage(named: "star_chip_icon")

        let icon: IconType
        let color: UIColor?
        
    }
    
    enum IconType {
        case next
        case tick
        case cross
        case other(image: UIImage)
        
        var image: UIImage {
            switch self {
            case .next:
                return UIImage(named: "arrow-right-large") ?? UIImage()
            case .tick:
                return UIImage(named: "IOS IconscheckmarkNo") ?? UIImage()
            case .cross:
                return UIImage(named: "IOS IconscloseNo") ?? UIImage()
            case .other(image: let image):
                return image
            }
        }
    }
    
    
    // MARK: Components
    
    struct Components {
        let input: ComponentInput
        let color: UIColor?
    }
    
    enum ComponentInput {
        case title(text: TextInput)
        case twoHorizontalLabels(leftText: TextInput, rightText: String)
        case twoVerticalLabels(upperText: String, lowerText: String)
        case icon(icon: IconType)
                  
        var result: ComponentOptions {
            switch self {
                
            case .title(text: let text):
                return ComponentOptions.init(mainText: .init(text: text.text, isBold: text.isBold, isLarge: text.isLarge), upperRightText: nil, lowerRightText: nil, icon: nil)
                
            case .twoHorizontalLabels(leftText: let leftText, rightText: let rightText):
                return ComponentOptions.init(mainText: .init(text: leftText.text, isBold: leftText.isBold, isLarge: leftText.isLarge), upperRightText: rightText, lowerRightText: nil, icon: nil)
                
            case .twoVerticalLabels(upperText: let upperText, lowerText: let lowerText):
                return ComponentOptions.init(mainText: nil, upperRightText: upperText, lowerRightText: lowerText, icon: nil)
            case .icon(icon: let icon):
                return ComponentOptions.init(mainText: nil, upperRightText: nil, lowerRightText: nil, icon: icon)
            }
        }
    }
    
    struct ComponentOptions {
        let mainText: TextInput? // main text or ther upper right text
        let upperRightText: String?
        let lowerRightText: String?
        let icon: IconType?
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    private var actionClosure: (() -> Void)?

//    @objc func tapAction() {
//        actionClosure?()
//    }
    
    private var flexibleTableViewCell = UIView()
 
    var titleLabel = UILabel()
    var leftIcon: UIImageView?
    var rightIcon: UIImageView?
    var firstComponentLabel: UILabel?
    var secondComponentLabel: UILabel?
    var removeButton: UIButton?

    var input: Input?
    
    
    static let reuseIdentifier = "FlexibleTableViewCell"
    
    
    var delegate: FlexibleTableViewCellButtonDelegate?
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
    }
    
        
    
    func setup(input: Input) {
        
        
        if flexibleTableViewCell.superview != nil {
            // Update the existing cell's content
            self.configure(with: input)
        } else {
            // Cell is not yet created, create and configure it
            initialize(input: input)
        }
        
    }
    
    func initialize(input: Input) {
        
        self.input = input
        // Corners
        
        self.isUserInteractionEnabled = true
        self.selectionStyle = .default
                
        contentView.addSubview(flexibleTableViewCell)
        flexibleTableViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flexibleTableViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            flexibleTableViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            flexibleTableViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            flexibleTableViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])

        if let corners = input.corners {
            flexibleTableViewCell.layer.borderColor = Colors.gray200.color.cgColor
            flexibleTableViewCell.layer.borderWidth = 1
            
            if corners.isRounded {
                flexibleTableViewCell.layer.cornerRadius = 10
            }
        }

// Left Stack View --> title and icon?
        
        let leftStackView = UIStackView()
        leftStackView.axis = .horizontal
        leftStackView.spacing = 14
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        flexibleTableViewCell.addSubview(leftStackView)
// leftIcon
                
        if let icon = input.leftIcon {
            let leftIcon = UIImageView()
            
            leftIcon.translatesAutoresizingMaskIntoConstraints = false
                        
            if let color = input.leftIcon?.color {
                leftIcon.image = icon.icon.image.withTintColor(color)
            } else {
                leftIcon.image = icon.icon.image
            }
            
            NSLayoutConstraint.activate([
                leftIcon.heightAnchor.constraint(equalToConstant: 30),
                leftIcon.widthAnchor.constraint(equalToConstant: 30),
            ])
            
            leftIcon.contentMode = .scaleAspectFit
            
            leftStackView.addArrangedSubview(leftIcon)
            self.leftIcon = leftIcon
        }
        
        
// titleLabel
        
        
        titleLabel.text = input.title.text
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        
        if input.title.isLarge {
            if input.title.isBold {
                titleLabel.font = Fonts.headline17.font
            } else {
                titleLabel.font = Fonts.body17.font
            }
        } else {
            if input.title.isBold {
                titleLabel.font = Fonts.footnoteBold13.font
            } else {
                titleLabel.font = Fonts.footnoteRegular13.font
            }
        }
        
        leftStackView.addArrangedSubview(titleLabel)
        
        
        let newlineCount = CGFloat(countNewlines(in: input.title.text)) + 1
        
        if input.title.text.contains("\n") {
            if input.title.isLarge {
                leftStackView.heightAnchor.constraint(equalToConstant: newlineCount*22).isActive = true
            } else {
                leftStackView.heightAnchor.constraint(equalToConstant: newlineCount*18).isActive = true
            }
        } else {
            leftStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: flexibleTableViewCell.leadingAnchor, constant: 14),
            leftStackView.bottomAnchor.constraint(equalTo: flexibleTableViewCell.bottomAnchor, constant: -14),
            leftStackView.topAnchor.constraint(equalTo: flexibleTableViewCell.topAnchor, constant: 14),
        ])
        
    
        
        
// Components --> left, upper-right, lower-right labels or icon
        if let comps = input.components?.input.result {
            
            // only icon
            if let image = comps.icon {
                
                let rightIcon = UIImageView()
                
                if let color = input.components?.color {
                    rightIcon.image = image.image.withTintColor(color)
                } else {
                    rightIcon.image = image.image
                }
                
                flexibleTableViewCell.addSubview(rightIcon)
                rightIcon.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    rightIcon.trailingAnchor.constraint(equalTo: flexibleTableViewCell.trailingAnchor, constant: -14),
                    rightIcon.heightAnchor.constraint(equalToConstant: 24),
                    rightIcon.widthAnchor.constraint(equalToConstant: 24),
                    rightIcon.centerYAnchor.constraint(equalTo: flexibleTableViewCell.centerYAnchor)
                ])
                
                self.rightIcon = rightIcon
                
            // two vertical labels
            } else if let lowerText = comps.lowerRightText, let upperText = comps.upperRightText {
                
                let upperLabel = UILabel()
                let lowerLabel = UILabel()
                
                upperLabel.font = Fonts.caption1Regular12.font
                lowerLabel.font = Fonts.caption1Regular12.font
                
                upperLabel.text = upperText
                lowerLabel.text = lowerText
                
                upperLabel.textAlignment = .right
                lowerLabel.textAlignment = .right
                
                
                let stackView = UIStackView()
                stackView.axis = .vertical
                stackView.spacing = 6
                self.addSubview(stackView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                stackView.addArrangedSubview(upperLabel)
                stackView.addArrangedSubview(lowerLabel)
                

                firstComponentLabel = upperLabel
                secondComponentLabel = lowerLabel
                
                let removeButton = UIButton()
                self.removeButton = removeButton
                removeButton.setImage(UIImage(named: "delete-minus-icon")?.withTintColor(.danger500) ?? UIImage(), for: .normal)
                
                removeButton.translatesAutoresizingMaskIntoConstraints = false
                
                flexibleTableViewCell.addSubview(removeButton)
                
                removeButton.addTarget(self, action: #selector(removeAction), for: .touchUpInside)
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAction))
//                removeImgView.addGestureRecognizer(tapGesture)
                
//                if lowerText ==
                
                let numberString = lowerText.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted)
                if let number = Int(numberString) {
                    if number == 0 {
                        removeButton.isHidden = true
                    } else {
                        removeButton.isHidden = false
                    }
                }
                
                let commonStackView = UIStackView()
                commonStackView.axis = .horizontal
                commonStackView.spacing = 14
                
                flexibleTableViewCell.addSubview(commonStackView)
                commonStackView.translatesAutoresizingMaskIntoConstraints = false
                
                commonStackView.addArrangedSubview(stackView)
                commonStackView.addArrangedSubview(removeButton)
                
                NSLayoutConstraint.activate([
                    
                    commonStackView.trailingAnchor.constraint(equalTo: flexibleTableViewCell.trailingAnchor, constant: -14),
                    commonStackView.centerYAnchor.constraint(equalTo: flexibleTableViewCell.centerYAnchor),
                ])
                
                
            // two horizontal labels
            } else if let leftText = comps.mainText, let rightText = comps.upperRightText {
                
                let leftLabel = UILabel()
                let rightLabel = UILabel()
                
                leftLabel.font = Fonts.caption1Regular12.font
                rightLabel.font = Fonts.caption1Regular12.font
                
                leftLabel.text = leftText.text
                rightLabel.text = rightText
                
                leftLabel.textAlignment = .left
                rightLabel.textAlignment = .left
                
                
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.spacing = 0
                stackView.distribution = .fillEqually
                
                flexibleTableViewCell.addSubview(stackView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                stackView.addArrangedSubview(leftLabel)
                stackView.addArrangedSubview(rightLabel)
                
                NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: flexibleTableViewCell.leadingAnchor, constant: 120),
                    stackView.centerYAnchor.constraint(equalTo: flexibleTableViewCell.centerYAnchor),
                    stackView.trailingAnchor.constraint(equalTo: flexibleTableViewCell.trailingAnchor, constant: -14)
                ])
        
                firstComponentLabel = leftLabel
                secondComponentLabel = rightLabel

                
            // one label
            } else if let text = comps.mainText {
                
                let singleLabel = UILabel()
                
                if text.isLarge {
                    if text.isBold {
                        singleLabel.font = Fonts.headline17.font
                    } else {
                        singleLabel.font = Fonts.body17.font
                    }
                } else {
                    if text.isBold {
                        singleLabel.font = Fonts.footnoteBold13.font
                    } else {
                        singleLabel.font = Fonts.footnoteRegular13.font
                    }
                }

                singleLabel.text = text.text
                singleLabel.translatesAutoresizingMaskIntoConstraints = false
                
                singleLabel.textColor = input.components?.color
                
                flexibleTableViewCell.addSubview(singleLabel)
         
                NSLayoutConstraint.activate([
                    singleLabel.trailingAnchor.constraint(equalTo: flexibleTableViewCell.trailingAnchor, constant: -14),
                    singleLabel.centerYAnchor.constraint(equalTo: flexibleTableViewCell.centerYAnchor)
                ])

                firstComponentLabel = singleLabel
                
            }
            
        }

    }
    
    @objc func removeAction() {
//        delegate?.buttonTapped(for: self)
        removeClosure?()
    }
    
    func countNewlines(in inputString: String) -> Int {
        let newlineArray = inputString.components(separatedBy: "\n")
        return newlineArray.count - 1 // Subtract 1 to get the newline count
    }
    
}

extension FlexibleTableViewCell {
    func configure(with input: Input) {
        titleLabel.text = input.title.text
        
        if let icon = input.leftIcon {
            if let color = input.leftIcon?.color {
                leftIcon?.image = icon.icon.image.withTintColor(color)
            } else {
                leftIcon?.image = icon.icon.image
            }
        }
        
        // Components --> left, upper-right, lower-right labels or icon
        if let comps = input.components?.input.result {
            
                // only icon
            if let image = comps.icon {
                
                if let color = input.components?.color {
                    rightIcon?.image = image.image.withTintColor(color)
                } else {
                    rightIcon?.image = image.image
                }

                // two vertical labels
            } else if let lowerText = comps.lowerRightText, let upperText = comps.upperRightText {
                
                firstComponentLabel?.text = upperText
                secondComponentLabel?.text = lowerText

                let numberString = lowerText.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted)
                if let number = Int(numberString) {
                    if number == 0 {
                        removeButton?.isHidden = true
                    } else {
                        removeButton?.isHidden = false
                    }
                }
                // two horizontal labels
            } else if let leftText = comps.mainText, let rightText = comps.upperRightText {
                
                firstComponentLabel?.text = leftText.text
                secondComponentLabel?.text = rightText
                
                // one label
            } else if let text = comps.mainText {
                
                firstComponentLabel?.text = text.text
                
            }
        }
    }
    
    func changeChosenCount(newNum: Int) {
        secondComponentLabel?.text = "Выбрано: \(newNum)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
}

