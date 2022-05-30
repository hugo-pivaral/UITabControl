//
//  UITabControl.swift
//  UITabControl
//
//  Created by Hugo Pivaral on 29/05/22.
//

import UIKit

public class UITabControl: UIControl {
    
    
    // MARK: PROPERTIES
    
    internal var appearance: Appearance = Appearance()
    
    public var selectedTabIndex: Int! {
        didSet {
            setTabSelected()
        }
    }
    
    internal var tabs: [String]!
    
    
    // MARK: - INIT
    
    public convenience init(tabs: [String], appearance: Appearance = Appearance()) {
        self.init()
        self.tabs = tabs
        self.appearance = appearance
        setUp()
        setTabs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    
    // MARK: VIEWS
    
    internal lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: appearance.contentInset, bottom: 0, right: appearance.contentInset)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    internal var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var selectedTabHighlight: UIView = {
        let selectedTabHighlight = UIView()
        
        selectedTabHighlight.translatesAutoresizingMaskIntoConstraints =  false
        
        return selectedTabHighlight
    }()
    
    internal var selectedTabHighlightCenterX: NSLayoutConstraint!
    
    internal var selectedTabHighlightWidth: NSLayoutConstraint!
    
    
    // MARK: PUBLIC METHODS
    
    public func setTabs(_ tabs: [String]) {
        self.tabs = tabs
        setTabs()
    }
    
    public func setAppearance(_ appearance: Appearance) {
        self.appearance = appearance
    }
    
    
    // MARK: PRIVATE HELPERS
    
    private func setUp() {
        setConstraints()
        setSelectedTabHighlightView()
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        scrollView.insertSubview(selectedTabHighlight, at: 0)
        selectedTabHighlightCenterX = selectedTabHighlight.centerXAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0)
        selectedTabHighlightWidth = selectedTabHighlight.widthAnchor.constraint(equalToConstant: 0)
    }
    
    private func setTabs() {
        guard tabs.count > 0 else { return }
        
        cleanTabControl()
        
        // Set new tabs
        for tabTitle in tabs {
            let tab = UITab(title: tabTitle, textColor: appearance.textColor, selectedTextColor: appearance.selectedTabTextColor)
            tab.addTarget(self, action: #selector(handleTouchEvents(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(tab)
            if stackView.arrangedSubviews.firstIndex(of: tab)! < tabs.count - 1 {
                setTabSeparator()
            }
        }
        selectedTabIndex = 0
    }
    
    private func cleanTabControl() {
        for view in stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        guard scrollView.subviews.count > 1 else { return }
        for view in self.subviews {
            if view != stackView && view != scrollView {
                view.removeFromSuperview()
            }
        }
    }
    
    private func setTabSeparator() {
        guard appearance.separatorEnabled else { return }
        
        let separator = UIView()
        separator.backgroundColor = appearance.separatorColor
        separator.layer.cornerRadius = 0.5
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.layoutIfNeeded()
        
        self.insertSubview(separator, at: 0)
        separator.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: stackView.frame.size.width - 0.5).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 14).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setSelectedTabHighlightView() {
        switch appearance.style {
        case .rounded:
            applySelectedTabHighlightViewShadow()
            selectedTabHighlight.layer.cornerRadius = 7
            selectedTabHighlight.backgroundColor = appearance.selectedTabBackgroundColor
            selectedTabHighlight.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
            selectedTabHighlight.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            
        case .circular:
            applySelectedTabHighlightViewShadow()
            selectedTabHighlight.layer.cornerRadius = 16
            selectedTabHighlight.backgroundColor = appearance.selectedTabBackgroundColor
            selectedTabHighlight.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
            selectedTabHighlight.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            
        case .underline:
            selectedTabHighlight.backgroundColor = appearance.selectedTabTextColor
            selectedTabHighlight.layer.cornerRadius = 1
            selectedTabHighlight.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            selectedTabHighlight.heightAnchor.constraint(equalToConstant: 2.5).isActive = true
            
        case .none:
            break
        }
    }
    
    private func applySelectedTabHighlightViewShadow() {
        guard appearance.selectedTabShadowEnabled else { return }
        selectedTabHighlight.layer.borderWidth = 0.5
        selectedTabHighlight.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        selectedTabHighlight.layer.shadowColor = UIColor.black.cgColor
        selectedTabHighlight.layer.shadowOpacity = 0.14
        selectedTabHighlight.layer.shadowOffset = CGSize(width: 0, height: 2)
        selectedTabHighlight.layer.shadowRadius = 4.0
    }
    
    @objc private func handleTouchEvents(_ sender: UITab) {
        // De-select subviews
        for tab in stackView.arrangedSubviews {
            guard let tab = tab as? UIControl else { return }
            tab.isSelected = false
        }
        // Set new selected tab
        selectedTabIndex = stackView.arrangedSubviews.firstIndex(of: sender)
        sendActions(for: .valueChanged)
    }
}
