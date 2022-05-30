//
//  UITab.swift
//  UITabControl
//
//  Created by Hugo Pivaral on 29/05/22.
//

import UIKit

struct Padding {
    var vertical: CGFloat
    var horizontal: CGFloat
}

class UITab: UIControl {
    
    var textColor: UIColor!
    var selectedTextColor: UIColor!
    
    private var title: String!
    private var titleLabel: UILabel!
    private var padding: Padding = Padding(vertical: 8, horizontal: 16)
    
    override var isSelected: Bool {
        didSet {
            let color = isSelected ? selectedTextColor : textColor
            let font = UIFont.systemFont(ofSize: (isSelected ? 14.40 : 15), weight: (isSelected ? .semibold : .regular))
            UIView.transition(with: self.titleLabel, duration: 0.15, options: [.transitionCrossDissolve]) { [weak self] in
                self?.titleLabel.font = font
                self?.titleLabel.textColor = color
            }
        }
    }
    
    convenience init(title: String, textColor: UIColor, selectedTextColor: UIColor) {
        self.init()
        self.title = title
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.setUp()
    }
    
    private func setUp() {
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.isUserInteractionEnabled = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding.vertical).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.horizontal).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.vertical).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.horizontal).isActive = true
        
    }
}
