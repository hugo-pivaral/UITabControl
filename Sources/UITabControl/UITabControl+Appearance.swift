//
//  UITabControlAppearance.swift
//  UITabControl
//
//  Created by Hugo Pivaral on 29/05/22.
//

import UIKit

extension UITabControl {
    
    public enum Style {
        case rounded
        case circular
        case underline
    }
    
    public struct Appearance {
        var style: Style!
        var textColor: UIColor!
        var contentInset: CGFloat!
        var separatorColor: UIColor!
        var separatorEnabled: Bool!
        var selectedTabTextColor: UIColor!
        var selectedTabShadowEnabled: Bool!
        var selectedTabBackgroundColor: UIColor!
        
        public init(style: Style = .rounded,
                    textColor: UIColor = .label,
                    contentInset: CGFloat = 20,
                    separatorColor: UIColor = .separator,
                    separatorEnabled: Bool = true,
                    selectedTabTextColor: UIColor = .label,
                    selectedTabShadowEnabled: Bool = true,
                    selectedTabBackgroundColor: UIColor = .activeTabBackground) {
            self.style = style
            self.textColor = textColor
            self.contentInset = contentInset
            self.separatorColor = separatorColor
            self.separatorEnabled = separatorEnabled
            self.selectedTabTextColor = selectedTabTextColor
            self.selectedTabShadowEnabled = selectedTabShadowEnabled
            self.selectedTabBackgroundColor = selectedTabBackgroundColor
        }
    }
}
