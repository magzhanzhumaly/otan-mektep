//
//  InputBoxView.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 15.12.2023.
//

import UIKit

import DropDown

protocol InputBoxViewDelegate: AnyObject {
    func onFieldReturn(_ input: InputBoxView)
    func onFieldDidBeginEditing(_ input: InputBoxView)
    func onFieldDidEndEditing(_ input: InputBoxView)
    func input(_ input: InputBoxView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    func inputDidTapDelegate(_ input: InputBoxView)
//    func inputDidTapDate(_ input: InputBoxView)
//    func inputDidTapTime(_ input: InputBoxView)
}

extension InputBoxViewDelegate {
    func onFieldReturn(_ input: InputBoxView) {}
    func onFieldDidBeginEditing(_ input: InputBoxView) {}
    func onFieldDidEndEditing(_ input: InputBoxView) {}
    func input(_ input: InputBoxView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { true }
    func inputDidTapDelegate(_ input: InputBoxView) {}
//    func inputDidTapDate(_ input: InputBoxView) {}
//    func inputDidTapTime(_ input: InputBoxView) {}
}


class InputBoxView: UIView {
    struct Caption {
        let text: String
        let icon: UIImage?
        let action: (String, () -> Void)?
    }
    
    struct Input {
        let isLarge: Bool
        let isRequired: Bool
        let isSecure: Bool
        let date: String?
        let time: String?
        let label: String?
        let placeholder: String?
        let caption: Caption?
        let dropdownOptions: [String]?
        let state: State
    }
        
    enum State {
        case empty
        case active
        case filled
        case error
        case success
        case disabled
        
        var colorNames: [Colors] {
            switch self {
            case .empty:
                return [.gray50, .gray200, .gray600, .gray400]
            case .active:
                return [.other, .primary600, .gray600, .gray800]
            case .filled:
                return [.gray50, .gray200, .gray600, .gray800]
            case .error:
                return [.warning50, .danger600, .danger600, .gray800]
            case .success:
                return [.success50, .success600, .success600, .gray800]
            case .disabled:
                return [.gray200, .gray200, .gray600, .gray500]
            }
        }
    }

    /// Main sub view
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

    // Need for state control
    private var labelView: UIView? // for top label
    private var contentView: UIView? // for content
    private var captionView: UIView? // for caption

    /// Drop down (need for recolor)
    private let dropDown = DropDown()
    private var dropDownLabel: UILabel? // (need for recolor)
    private var timeAndDateLabel: UILabel? // (need for recolor)
    
    /// Top label
    private var label: UILabel? // (need for recolor)

    /// Caption
    public var captionLabel: UILabel? // (need for recolor)
    private var captionIcon: UIImageView? // (need for recolor)

    /// Input field
    var textField: UITextField? // (need for recolor)
    
    var state: State

    public weak var delegate: InputBoxViewDelegate?
    private let dateButton = UIButton(type: .custom)

    public var isCloseOnReturn: Bool = true
    public var isRemoveCaptionOnActive: Bool = true

//    public var isDelegateDropDown: Bool = false
//    public var isDelegateDate: Bool = false
//    public var isDelegateTime: Bool = false

    public var isDelegate: Bool = false

    public var text: String? {
        get {
            textField?.text ?? dropDownLabel?.text ?? timeAndDateLabel?.text
        }
        set {
            if let textField {
                textField.text = newValue
            } else if (timeAndDateLabel != nil) {
                timeAndDateLabel?.text = newValue
            } else {
                dropDownLabel?.text = newValue
                setState(.active)
            }
        }
    }
    
    public var placeholder: String? {
        get {
            textField?.placeholder ?? dropDownLabel?.text
        }
        set {
            if let textField {
                textField.placeholder = newValue
            } else {
                dropDownLabel?.text = newValue
                setState(.empty)
            }
        }
    }

    public var keyboardType: UIKeyboardType? {
        get {
            textField?.keyboardType
        }
        set {
            if newValue == .URL || newValue == .emailAddress {
                textField?.autocapitalizationType = .none
            }
            textField?.keyboardType = newValue ?? .default
        }
    }
    
    public var isSecureTextEntry: Bool {
        get {
            textField?.isSecureTextEntry ?? false
        }
        set {
            textField?.isSecureTextEntry = newValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(input: Input) {
        state = input.state

        super.init(frame: .zero)
        self.layer.masksToBounds = true
        addFilledSubview(stackView)
        
        if input.label != nil || input.isRequired {
            addTopLabelIfNeeded(with: input.label, isRequired: input.isRequired)
        }
        
        addConentView(input.isLarge, input.placeholder, input.isSecure, input.dropdownOptions, input.date, input.time)

        if let caption = input.caption {
            addCaptionView(caption)
        }

        updateColors()
    }
    
    private func addTopLabelIfNeeded(with label: String?, isRequired: Bool) {
        let view = UIView()
        self.labelView = view
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        view.heightAnchor.constraint(equalToConstant: 16).isActive = true

        if let labelText = label {
            let label = UILabel()
            label.text = labelText
            label.font = Fonts.body17.font

            label.translatesAutoresizingMaskIntoConstraints = false
            self.label = label
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
        
        if isRequired {
            let asterix = UILabel()
            asterix.text = "*"
            asterix.font = Fonts.body17.font
            asterix.textColor = Colors.danger600.color
            
            asterix.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(asterix)
            NSLayoutConstraint.activate([
                asterix.topAnchor.constraint(equalTo: view.topAnchor),
                asterix.leadingAnchor.constraint(equalTo: self.label?.trailingAnchor ?? leadingAnchor, constant: 4),
            ])
        }
    }

    private func addConentView(_ isLarge: Bool, _ placeholder: String?, _ isSecure: Bool, _ dropdownOptions: [String]?, _ date: String?, _ time: String?) {
        let view = UIView()
        self.contentView = view
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        stackView.addArrangedSubview(view)
        view.heightAnchor.constraint(equalToConstant: isLarge ? 50 : 42).isActive = true

        if let dropDownMenu = dropdownOptions {
            let anch = UIView()
            anch.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(anch)

            let button = UIButton()
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)

            let label = UILabel()
            label.text = placeholder
            label.font = Fonts.body17.font
            label.translatesAutoresizingMaskIntoConstraints = false
            dropDownLabel = label
            view.addSubview(label)
            
            let dropDownImageView = UIImageView()
            dropDownImageView.image = UIImage(named: "dropDown")
            dropDownImageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(dropDownImageView)
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                button.topAnchor.constraint(equalTo: view.topAnchor),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                anch.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                anch.topAnchor.constraint(equalTo: button.bottomAnchor),
                anch.trailingAnchor.constraint(equalTo: button.trailingAnchor),

                label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
                label.topAnchor.constraint(equalTo: button.topAnchor),
                label.bottomAnchor.constraint(equalTo: button.bottomAnchor),

                dropDownImageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: 8),
                dropDownImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),

                trailingAnchor.constraint(equalTo: dropDownImageView.trailingAnchor, constant: 12),
                dropDownImageView.widthAnchor.constraint(equalToConstant: 22),
                dropDownImageView.heightAnchor.constraint(equalToConstant: 22),
            ])

            dropDown.anchorView = anch
            dropDown.dataSource = dropDownMenu
            dropDown.direction = .any
            dropDown.selectionAction = { // [unowned self]
                (index: Int, item: String) in
                self.text = item
            }
            
            isDelegate = true
            
        } else if date != nil && time == nil {
            
            let placeholderLabel = UILabel()
            
//            if placeholder == nil {
            placeholderLabel.text = date
//            self.text = placeholderLabel.text
//            } else {
//                placeholderLabel.text = placeholder
//            }
            
            placeholderLabel.font = Fonts.body17.font
            placeholderLabel.textColor = Colors.gray400.color
            timeAndDateLabel = placeholderLabel
  
            view.addSubview(timeAndDateLabel!)
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                placeholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])

            dateButton.setImage(UIImage(named: "datePickerView")?.withRenderingMode(.alwaysTemplate), for: .normal)
            dateButton.translatesAutoresizingMaskIntoConstraints = false
            dateButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

            view.addSubview(dateButton)
            
            NSLayoutConstraint.activate([
                dateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                dateButton.widthAnchor.constraint(equalToConstant: 22),
                dateButton.heightAnchor.constraint(equalToConstant: 22),
                dateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])

            isDelegate = true
        } else if time != nil && date == nil {
            
            let placeholder = UILabel()
            placeholder.text = time
            
//            self.text = placeholder.text
            
            placeholder.font = Fonts.body17.font
            placeholder.textColor = Colors.gray400.color
            timeAndDateLabel = placeholder
            view.addSubview(timeAndDateLabel!)
            placeholder.textColor = Colors.gray400.color
            placeholder.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])

            dateButton.setImage(UIImage(named: "info-clock")?.withRenderingMode(.alwaysTemplate), for: .normal)
            dateButton.imageView?.tintColor = Colors.gray400.color

            dateButton.translatesAutoresizingMaskIntoConstraints = false
            dateButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            
            view.addSubview(dateButton)
            
            NSLayoutConstraint.activate([
                dateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                dateButton.widthAnchor.constraint(equalToConstant: 22),
                dateButton.heightAnchor.constraint(equalToConstant: 22),
                dateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])

            isDelegate = true
        } else {
            
            let attributedPlaceholderText = NSAttributedString(string: placeholder ?? "",
                                                               attributes: [NSAttributedString.Key.foregroundColor: state.colorNames[3].color])
            
            let textField = UITextField()
            textField.attributedPlaceholder = attributedPlaceholderText
            
            textField.delegate = self
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            textField.leftViewMode = .always
            textField.leftView = UIView(frame: CGRect(x:0, y:0, width:16, height:0))
            textField.font = Fonts.body17.font
            
            self.textField = textField
            view.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                textField.topAnchor.constraint(equalTo: view.topAnchor),
                textField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
            if isSecure {
                let button = UIButton(type: .custom)
                button.setImage(UIImage(named: "eye"), for: .normal)
                button.setImage(UIImage(named: "eye-off"), for: .selected)
                button.addTarget(self, action: #selector(eyeAction(_:)), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(button)
                
                NSLayoutConstraint.activate([
                    button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    button.widthAnchor.constraint(equalToConstant: 44),
                    button.heightAnchor.constraint(equalToConstant: 44),
                    button.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                    button.leadingAnchor.constraint(equalTo: textField.trailingAnchor),

                ])

                isSecureTextEntry = true
                button.isSelected = true
            } else {
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            }
        }
    }

    private func addCaptionView(_ caption: Caption) {
        let view = UIView()
        self.captionView = view
        stackView.addArrangedSubview(view)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: stack.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let horStack = UIStackView()
        horStack.axis = .horizontal
        horStack.spacing = 4
        stack.addArrangedSubview(horStack)

        if let icon = caption.icon {
            let imageView = UIImageView()
            imageView.image = icon.withRenderingMode(.alwaysTemplate)
            imageView.contentMode = .scaleAspectFit
            self.captionIcon = imageView

            horStack.addArrangedSubview(imageView)
        }
        
        let label = UILabel()
        label.text = caption.text
        label.numberOfLines = 0
        label.font = Fonts.caption2Regular11.font
        
        label.translatesAutoresizingMaskIntoConstraints = false
        captionLabel = label
        
        horStack.addArrangedSubview(label)
        
        if let action = caption.action {
            let button = MyButton(input: .init(isLarge: false, isFilled: false, icon: nil, label: action.0))
            button.addAction(closure: action.1)
            stack.addArrangedSubview(button)
        }
    }

    @objc private func didTapButton(sender: UIButton!) {
        
        if isDelegate {
            delegate?.inputDidTapDelegate(self)
        }
//        if is
    }

    func setState(_ state: State) {
        if state == .empty || state == .active {
            if isRemoveCaptionOnActive {
                removeCaption()
            }
        }
        self.state = state
        updateColors()
    }
    
    func recolor(to state: State, for timeInSeconds: Double) {
        recolor(for: state)
        
        DispatchQueue.main.asyncAfter (deadline: .now () + timeInSeconds) {
            self.recolor(for: self.state)
        }
    }
    
    func recolorForTwoSeconds(to state: State) {
        recolor(to: state, for: 2)
    }

    private func updateColors() {
        recolor(for: state)
    }
    
    private func recolor(for state: State) {
        let colors = state.colorNames

        dateButton.imageView?.tintColor = colors[3].color
        timeAndDateLabel?.textColor = colors[3].color
        
        textField?.textColor = colors[3].color
        dropDownLabel?.textColor = colors[3].color
        contentView?.layer.borderColor = colors[1].color.cgColor
        contentView?.backgroundColor = colors[0].color

        label?.textColor = colors[2].color
        captionIcon?.tintColor = colors[2].color
        captionLabel?.textColor = colors[2].color
    }
    
    func addErrorMessage(_ message: String?, and action: (String, () -> Void)? = nil) {
        if let message {
            removeCaption()
            addCaptionView(.init(text: message, icon: nil, action: action))
        }
        setState(.error)
    }

    private func removeCaption() {
        captionView?.removeFromSuperview()
        captionView = nil
    }

    override var isFirstResponder: Bool {
        textField?.isFirstResponder ?? false
    }
    
    @discardableResult
    override func becomeFirstResponder () -> Bool {
        textField?.becomeFirstResponder () ?? false
    }
    
    @discardableResult
    override func resignFirstResponder () -> Bool {
        textField?.resignFirstResponder () ?? false
    }
    
    @objc private func eyeAction(_ button: UIButton) {
        button.isSelected.toggle()
        isSecureTextEntry = button.isSelected
    }
}

extension InputBoxView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textfield: UITextField) {
        setState(.active)
        delegate?.onFieldDidBeginEditing(self)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setState(.empty)
        delegate?.onFieldDidEndEditing(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isCloseOnReturn {
            resignFirstResponder()
        }
        delegate?.onFieldReturn(self)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.input(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
}

