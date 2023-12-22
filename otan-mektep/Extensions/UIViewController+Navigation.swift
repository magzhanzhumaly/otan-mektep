//
//  UIViewController+Navigation.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 22.12.2023.
//

import UIKit

enum Navigation {
    class Action {
        enum Info {
            case text(String)
            case image(UIImage)

            init?(_ txt: String? = nil, _ img: UIImage? = nil) {
                if let txt {
                    self = .text(txt)
                } else if let img {
                    self = .image(img)
                } else {
                    return nil
                }
            }
        }

        fileprivate let style: Info?
        fileprivate let needArrow: Bool
        fileprivate let actionClosure: (() -> Void)?

        init(style: Info? = nil, needArrow: Bool = false, actionClosure: (() -> Void)?) {
            self.style = style
            self.needArrow = needArrow
            self.actionClosure = actionClosure
        }

        fileprivate func barButtonItem(for left: Bool) -> UIBarButtonItem {
            return UIBarButtonItem(button: button(for: left))
        }

        fileprivate func button(for left: Bool) -> UIButton {
            let arrowImage = UIImage(named: "arrow-\(left ? "left" : "right")-large")
            var text: String?
            var image: UIImage?
            switch style {
            case .text(let txt):
                if needArrow {
                    image = arrowImage
                }
                text = txt
            case .image(let img):
                image = img
            case .none:
                if needArrow {
                    image = arrowImage
                }
            }

            return UIButton(image: image,
                            title: text,
                            left: left,
                            target: self,
                            action: actionClosure == nil ? nil : #selector(action))
        }

        @objc private func action() {
            actionClosure?()
        }
    }

    class Info: UIView {
        struct Input {
            let title: String
            let image: UIImage?
            let closure: (() -> Void)?
        }

        private var closure: (() -> Void)?
        private var mainStack: UIStackView?
        private var imageHeight: NSLayoutConstraint?

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init(with input: Input) {
            self.closure = input.closure
            super.init(frame: .zero)
            
            let mainStack = UIStackView()
            mainStack.axis = .vertical
            mainStack.alignment = .center
            mainStack.distribution = .fill
            mainStack.spacing = 8
            mainStack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.isUserInteractionEnabled = false
            addSubview(mainStack)
            leadingAnchor.constraint(equalTo: mainStack.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: mainStack.trailingAnchor).isActive = true
            topAnchor.constraint(equalTo: mainStack.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: mainStack.bottomAnchor).isActive = true
            self.mainStack = mainStack
            
            let imageView = UIImageView(image: input.image)
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            imageHeight = imageView.heightAnchor.constraint(equalToConstant: 48)
            imageHeight?.isActive = true
            imageView.layer.cornerRadius = 24
            mainStack.addArrangedSubview(imageView)
            
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = 4
            mainStack.addArrangedSubview(hStack)
            
            let label = UILabel()
            label.text = input.title
            hStack.addArrangedSubview(label)
            
            let arrow = UIImageView(image: UIImage(named: "arrow-right-large"))
            hStack.addArrangedSubview(arrow)
            
            if closure == nil {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
                addGestureRecognizer(tapGesture)
            }
        }
        
        @objc private func tapAction() {
            closure?()
        }
        
        func updateUI(large: Bool) {
            imageHeight?.constant = large ? 48 : 24
            mainStack?.axis = large ? .vertical : .horizontal
            layoutIfNeeded()
        }
    }

    struct Style {
        enum Input {
            case title(String)
            case info(Info.Input)
        }
        fileprivate let input: Input?
        fileprivate let left: [Action]
        fileprivate let right: [Action]
        fileprivate let segment: OtanMektepSegment.Input?
        fileprivate let large: Bool
        
        init(input: Input? = nil,
             left: [Action] = [],
             right: [Action] = [],
             segment: OtanMektepSegment.Input? = nil,
             large: Bool = true) {
            self.input = input
            self.left = left
            self.right = right
            self.segment = segment
            self.large = large
        }
    }

    struct ActionInfo {
        let title: String?
        let image: UIImage?
        let needArrow: Bool
        let closure: (() -> Void)?
        
        var action: Action {
            .init(style: .init(title, image),
                  needArrow: needArrow,
                  actionClosure: closure)
        }
        
        init(_ closure: @escaping () -> Void) {
            self.title = nil
            self.image = nil
            self.needArrow = true
            self.closure = closure
        }
        
        init(_ image: UIImage?,
             _ closure: @escaping () -> Void) {
            self.title = nil
            self.image = image
            self.needArrow = true
            self.closure = closure
        }
        
        init(_ title: String,
             _ closure: @escaping () -> Void) {
            self.title = title
            self.image = nil
            self.needArrow = true
            self.closure = closure
        }

        init(_ title: String?,
             _ image: UIImage? = nil,
             _ needArrow: Bool = false,
             _ closure: (() -> Void)? = nil) {
            self.title = title
            self.image = image
            self.needArrow = needArrow
            self.closure = closure
        }
    }

    static func title(_ title: String? = nil,
                      large: Bool = true,
                      segmentInfo: (info: [(String?, UIImage?)], closure: (Int) -> Void)? = nil,
                      leftAction: [ActionInfo] = [],
                      rightAction: [ActionInfo] = []) -> Style {
        let left: [Action] = leftAction.map(\.action)
        let right: [Action] = rightAction.map(\.action)
        var segment: OtanMektepSegment.Input?
        if let segmentInfo {
            let titles = segmentInfo.info.map({ Action.Info($0.0, $0.1) }).filter({ $0 != nil }) as! [Action.Info]
            segment = .init(titles: titles, actionClosure: segmentInfo.closure)
        }
        var input: Style.Input?
        if let title {
            input = .title(title)
        }
        return Style(input: input, left: left, right: right, segment: segment, large: large)
    }
    
    static func infoView(_ input: Info.Input,
                         leftAction: [ActionInfo] = [],
                         rightAction: [ActionInfo] = []) -> Style {
        let left: [Action] = leftAction.map(\.action)
        let right: [Action] = rightAction.map(\.action)
        return Style(input: .info(input), left: left, right: right, large: true)
    }
    
    static func onlyBackArrow(_ closure: @escaping () -> Void) -> Style {
        title(large: false, leftAction: [ActionInfo(nil, UIImage(named: "navigation_back_arrow"), false, closure)])
    }

    static func onlyTitleAndBackArrow(_ text: String, _ closure: @escaping () -> Void) -> Style {
        title(text, large: false, leftAction: [ActionInfo(nil, UIImage(named: "navigation_back_arrow"), false, closure)])
    }

    static func withBackArrow(and right: (title: String,
                                          closure: () -> Void),
                              _ closure: @escaping () -> Void) -> Style {
        title(large: false,
              leftAction: [ActionInfo(nil, UIImage(named: "navigation_back_arrow"), false, closure)],
              rightAction: [ActionInfo(right.title, nil, false, right.closure)])
    }
}

extension BaseViewController: UIScrollViewDelegate {
    ///Usage examples
    /**

     setNavigation(Navigation.infoView(.init(title: "User Name", image: UIImage(named: "ios-avatar"), closure: {}),
                             leftAction: [.init(nil, nil, true, {})],
                            rightAction: [.init("Right1", nil, true, {})]))

     setNavigation(Navigation.title("Some title",
                           large: true,
                        leftAction: [.init(nil, nil, true, {})],
                       rightAction: [.init("Right1", nil, true, {})]))

     setNavigation(Navigation.title("Some title",
                           large: true,
                      segmentInfo: ([("first", nil), ("second", nil), ("third", nil)], { _ in }),
                        leftAction: [.init(nil, nil, true, {})],
                       rightAction: [.init("Right1", nil, true, {})]))

     let searchController = UISearchController(searchResultsController: nil)
     searchController.searchResultsUpdater = UISearchResultsUpdating
     searchController.obscuresBackgroundDuringPresentation = false
     searchController.searchBar.placeholder = "Search artists"
     self.definesPresentationContext = true
     setNavigation(Navigation.title("Some title",
                           large: true,
                        leftAction: [.init(nil, nil, true, {})],
                       rightAction: [.init("Right1", nil, true, {})]),
                   searchController)

     */
    func setNavigation(_ style: Navigation.Style, _ searchController: UISearchController? = nil) {
        guard let navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = style.large
        navigationItem.leftBarButtonItems = style.left.map { $0.barButtonItem(for: true) }
        navigationItem.rightBarButtonItems = style.right.map { $0.barButtonItem(for: false) }
        setActions(style.left + style.right)

        navigationItem.searchController = searchController
        if let segmentInput = style.segment {
            navigationItem.titleView = OtanMektepSegment(input: segmentInput)
        }

        switch style.input {
        case .title(let text):
            navigationItem.title = text
        case .info(let infoInput):
            let infoView = Navigation.Info(with: infoInput)
            addInfoView(infoView)
        case .none:
            break
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let large = (navigationController?.navigationBar.bounds.height ?? 0) > 44
        if large, let infoView = navigationItem.titleView as? Navigation.Info {
            infoView.updateUI(large: true)
            navigationItem.titleView = nil
            addInfoView(infoView)
        } else if !large, let infoView = view.subviews.first(where: { $0 is Navigation.Info }) as? Navigation.Info {
            infoView.removeFromSuperview()
            infoView.updateUI(large: false)
            navigationItem.titleView = infoView
        }
    }
    
    private func addInfoView(_ infoView: Navigation.Info) {
        infoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoView)
        let top = UIApplication.shared.windows.first?.safeAreaInsets.top
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: (top ?? 0)).isActive = true
    }
    
    private func addSegmentedControl(_ control: UISegmentedControl?) {
        guard let control else { return }
        control.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(control)
        control.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        control.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
    }
}

private extension UIBarButtonItem {
    convenience init(button: UIButton) {
        self.init(customView: button)
    }
}

private extension UIButton {
    convenience init(
        image: UIImage?,
        title: String?,
        left: Bool,
        target: Any?,
        action: Selector?
    ) {
        self.init(type: .custom)
        setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)

        titleLabel?.lineBreakMode = .byTruncatingTail
        setTitle(title, for: .normal)
        if action != nil {
            setTitleColor(tintColor, for: .normal)
        } else {
            setTitleColor(.black, for: .normal)
            isUserInteractionEnabled = false
        }
        semanticContentAttribute = left ? .forceLeftToRight : .forceRightToLeft
        
        if let target, let action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
}

class AcadlyNavigation: UIView {
    let style: Navigation.Style
    init(style: Navigation.Style, searchInfo: (delegate: UISearchBarDelegate, placeholder: String)?) {
        self.style = style
        super.init(frame: .zero)
        
        let stackView = UIStackView()
        addFilledSubview(stackView)
        
        stackView.axis = .vertical
        
        let topView = UIView()
        
        var left: UIStackView?
        var right: UIStackView?
        
        if !style.left.isEmpty {
            let leftStack = UIStackView()
            style.left.forEach {
                let button = $0.button(for: true)
                leftStack.addArrangedSubview(button)
            }
            leftStack.translatesAutoresizingMaskIntoConstraints = false
            topView.addSubview(leftStack)
            NSLayoutConstraint.activate([
                leftStack.topAnchor.constraint(equalTo: topView.topAnchor),
                leftStack.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 8),
                leftStack.heightAnchor.constraint(equalToConstant: 44)
            ])
            left = leftStack

        }

        if !style.right.isEmpty {
            let rightStack = UIStackView()
            style.right.forEach {
                let button = $0.button(for: false)
                rightStack.addArrangedSubview(button)
            }
            rightStack.translatesAutoresizingMaskIntoConstraints = false
            topView.addSubview(rightStack)
            NSLayoutConstraint.activate([
                rightStack.topAnchor.constraint(equalTo: topView.topAnchor),
                topView.trailingAnchor.constraint(equalTo: rightStack.trailingAnchor, constant: 8),
                rightStack.heightAnchor.constraint(equalToConstant: 44)
            ])
            right = rightStack

        }

        var center: UIView?
        if let titleInfo = style.input {
            switch titleInfo {
            case .title(let text):
                let label = UILabel()
                label.text = text
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                label.heightAnchor.constraint(equalToConstant: 44).isActive = true
                center = label
            case .info(let info):
                center = Navigation.Info(with: info)
            }
            
            stackView.addArrangedSubview(topView)
            if let segmentInfo = style.segment {
                let segment = OtanMektepSegment(input: segmentInfo)
                let view = UIView()
                view.addFilledSubview(segment, with: .init(top: 8, left: 12, bottom: 8, right: 12))
                stackView.addArrangedSubview(view)
            }
        } else {
            if let segmentInfo = style.segment {
                let segment = OtanMektepSegment(input: segmentInfo)
                segment.translatesAutoresizingMaskIntoConstraints = false
                let view = UIView()
                view.addFilledSubview(segment, with: .init(top: 8, left: 8, bottom: 8, right: 8))
                center = view
            }
        }

        if let center {
            topView.addSubview(center)
            NSLayoutConstraint.activate([
                center.topAnchor.constraint(equalTo: topView.topAnchor),
                center.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
                center.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            ])
            if let left {
                center.leadingAnchor.constraint(greaterThanOrEqualTo: left.trailingAnchor).isActive = true
            }
            if let right {
                right.leadingAnchor.constraint(greaterThanOrEqualTo: center.trailingAnchor).isActive = true
            }
        } else {
            if left != nil || right != nil {
                topView.heightAnchor.constraint(equalToConstant: 44).isActive = true
                stackView.addArrangedSubview(topView)
            }
        }

        if let searchInfo {
            let searchBar = UISearchBar()
            searchBar.delegate = searchInfo.delegate
            searchBar.placeholder = searchInfo.placeholder
            let view = UIView()
            view.addFilledSubview(searchBar, with: .init(top: 4, left: 16, bottom: 4, right: 16))
            stackView.addArrangedSubview(view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

