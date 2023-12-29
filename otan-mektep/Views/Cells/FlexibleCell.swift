//
//  FlexibleCell.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 27.12.2023.
//

import UIKit

protocol FlexibleCellButtonDelegate: AnyObject {
    func buttonTapped()
}

class FlexibleCell: UIView {
    
    weak var delegate: FlexibleCellButtonDelegate?

    struct Input {
        let leftIcon: leftIconInput?
        let title: TextInput
        let components: Components?
        let corners: CornerInput?
        let closure: (() -> Void)?
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
    
    private var actionClosure: (() -> Void)?

    @objc func tapAction() {
        actionClosure?()
    }
    
    init(input: Input) {
        super.init(frame: .zero)

        actionClosure = input.closure

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
        
// Corners
        
        if let corners = input.corners {
            self.layer.borderColor = Colors.gray200.color.cgColor
            self.layer.borderWidth = 1
            
            if corners.isRounded {
                self.layer.cornerRadius = 10
            }
        }

// Left Stack View --> title and icon?
        
        let leftStackView = UIStackView()
        leftStackView.axis = .horizontal
        leftStackView.spacing = 14
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(leftStackView)
// leftIcon
                
        if let icon = input.leftIcon {
            let leftIcon = UIImageView()
            
            leftIcon.translatesAutoresizingMaskIntoConstraints = false
            
            if let color = input.leftIcon?.color {
                leftIcon.image = icon.icon.image.withTintColor(color)
            }
            
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
        }

        
        
// titleLabel
        
        let titleLabel = UILabel()
        
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
            leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            leftStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            leftStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
        ])
        
    
        
        
// Components --> left, upper-right, lower-right labels or icon
        if let comps = input.components?.input.result {
            
            
            // only icon
            if let image = comps.icon {
                
                let icon = UIImageView()
                
                if let color = input.components?.color {
                    icon.image = image.image.withTintColor(color)
                } else {
                    icon.image = image.image
                }
                
                self.addSubview(icon)
                icon.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
                    icon.heightAnchor.constraint(equalToConstant: 24),
                    icon.widthAnchor.constraint(equalToConstant: 24),
                    icon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
                
                
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
                
//                let deleteButton = UIButton()
//                deleteButton.translatesAutoresizingMaskIntoConstraints = false
//                
//                deleteButton.backgroundColor = .danger500
//                deleteButton.
                let removeImgView = UIImageView()
                removeImgView.image = UIImage(named: "IOS Iconsminus-squareYes")?.withTintColor(.danger500)
                removeImgView.translatesAutoresizingMaskIntoConstraints = false
                
                self.addSubview(removeImgView)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAction))
                removeImgView.addGestureRecognizer(tapGesture)
                
                NSLayoutConstraint.activate([
                    removeImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
                    removeImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                    removeImgView.heightAnchor.constraint(equalToConstant: 40),
                    removeImgView.widthAnchor.constraint(equalToConstant: 40),
                    
                    stackView.trailingAnchor.constraint(equalTo: removeImgView.leadingAnchor, constant: -14),
                    stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
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
                
                self.addSubview(stackView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                stackView.addArrangedSubview(leftLabel)
                stackView.addArrangedSubview(rightLabel)
                
                NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
                    stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                    stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
                ])

                
            // one label
            } else if let text = comps.mainText {
                
                let label = UILabel()
                
                if text.isLarge {
                    if text.isBold {
                        label.font = Fonts.headline17.font
                    } else {
                        label.font = Fonts.body17.font
                    }
                } else {
                    if text.isBold {
                        label.font = Fonts.footnoteBold13.font
                    } else {
                        label.font = Fonts.footnoteRegular13.font
                    }
                }

                label.text = text.text
                label.translatesAutoresizingMaskIntoConstraints = false
                
                self.addSubview(label)
         
                NSLayoutConstraint.activate([
                    label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
                    label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])

            }
            
//            self.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }

    }
    
    @objc func removeAction() {
        delegate?.buttonTapped()
        print("typed")
    }
    
    func countNewlines(in inputString: String) -> Int {
        let newlineArray = inputString.components(separatedBy: "\n")
        return newlineArray.count - 1 // Subtract 1 to get the newline count
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonTapped() {
        print("buttontapped")
    }
    
}
