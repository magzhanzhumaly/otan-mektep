//
//  MyButton.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 15.12.2023.
//

import UIKit

class MyButton: UIView {
    
    struct Input {
        let isLarge: Bool
        let isFilled: Bool
        let icon: (image: UIImage, position: IconPosition)?
        let label: String?
    }

    enum IconPosition {
        case left
        case right
    }
    
    enum Style {
        case largeSolid
        case smallSolid
        case largeText
        case smallText
        
        var height: CGFloat {
            switch self {
            case .largeSolid:
                return 50
            case .smallSolid:
                return 40
            case .largeText:
                return 44
            case .smallText:
                return 18
            }
        }

        var spacing: CGFloat {
            switch self {
            case .largeSolid, .smallSolid:
                return 10
            case .largeText:
                return 4
            case .smallText:
                return 2
            }
        }
        
        var font: UIFont {
            switch self {
            case .largeSolid, .smallSolid:
                return Fonts.headline17.font
            case .largeText:
                return Fonts.body17.font
            case .smallText:
                return Fonts.footnoteRegular13.font
            }
        }
    }
    
    private var label: UILabel?
    private var imageView: UIImageView?

    private var contentView: UIView?
    private var loadingView: UIView?

    private var isEnabled = true
    private var actionClosure: (() -> Void)?
    private var input: Input?

    private var isFilled: Bool {
        input?.isFilled ?? false
    }

    private var style: Style {
        let style: Style
        let isLarge = input?.isLarge ?? false
        if isFilled {
            style = isLarge ? .largeSolid : .smallSolid
        } else {
            style = isLarge ? .largeText : .smallText
        }
        return style
    }

    var foreground: UIColor {
        get {
            .fromName(isFilled ? .other : .primary600)
        }
        set {
            label?.textColor = newValue
            imageView?.tintColor = newValue
        }
    }

    var background: UIColor {
        get {
            .fromName(isFilled ? .primary600 : .other)
        }
        set {
            backgroundColor = newValue
        }
    }

    init(input: Input) {
        super.init(frame: .zero)
        self.input = input

        if isFilled {
            layer.cornerRadius = 10
            layer.masksToBounds = true
        }

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = style.spacing
        stackView.alignment = .center

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor)
        ])
        contentView = stackView

        backgroundColor = background
        heightAnchor.constraint(equalToConstant: style.height).isActive = true
        
        if let label = input.label {
            let textLabel = UILabel()
            textLabel.text = label
            textLabel.font = style.font
            textLabel.textColor = foreground
            stackView.addArrangedSubview(textLabel)

            self.label = textLabel
        }

        if let image = input.icon?.image {
            let imageView = UIImageView()
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = foreground
            if input.icon?.position != .left && label != nil {
                stackView.insertArrangedSubview(imageView, at: 1)
            } else {
                stackView.addArrangedSubview(imageView)
            }
            self.imageView = imageView
        }

        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
    }

    @objc func tapAction() {
        guard isEnabled else { return }
        actionClosure?()
    }
    
    func addAction(closure: @escaping () -> Void) {
        actionClosure = closure
    }
    
    func showLoading(with title: String?) {
        isEnabled = false
        contentView?.isHidden = true
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = style.spacing
        
        var label: UILabel?
        if let title {
            let textLabel = UILabel()
            textLabel.text = title
            textLabel.font = style.font
            textLabel.textColor = foreground
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(textLabel)
            label = textLabel
        }

        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = foreground
        if input?.icon?.position != .left && label != nil {
            stack.insertArrangedSubview(indicator, at: 1)
        } else {
            stack.addArrangedSubview(indicator)
        }
        indicator.startAnimating()

        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor)
        ])
        loadingView = stack
    }

    func hideLoading() {
        isEnabled = true
        loadingView?.removeFromSuperview()
        contentView?.isHidden = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
