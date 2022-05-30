//
//  UITabControl+Animations.swift
//  UITabControl
//
//  Created by Hugo Pivaral on 29/05/22.
//

import UIKit

extension UITabControl {
    
    internal func setTabSelected() {
        stackView.layoutIfNeeded()
        let tab = stackView.arrangedSubviews[selectedTabIndex] as! UITab
        tab.isSelected = true
        
        guard let tabCenter = tab.superview?.convert(tab.center, to: stackView).x else { return }
        let tabWidth = tab.frame.size.width
        
        selectedTabHighlightCenterX.isActive = true
        selectedTabHighlightCenterX.constant = tabCenter
        selectedTabHighlightWidth.isActive = true
        selectedTabHighlightWidth.constant = tabWidth + 1
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.setTabVisibleIfNeeded()
            self?.scrollView.layoutIfNeeded()
        }
    }
    
    internal func setTabVisibleIfNeeded() {
        let tab = stackView.arrangedSubviews[selectedTabIndex] as! UITab
        guard let tabOriginX = tab.superview?.convert(tab.frame.origin, to: self).x else { return }
        let tabWidth = tab.frame.size.width
        
        if tabOriginX < 0 {
            // Leading out of bounds
            let padding = selectedTabIndex == 0 ? appearance.contentInset : 10
            let newOffsetX = scrollView.contentOffset.x + tabOriginX - (padding ?? 10)
            scrollView.setContentOffset(CGPoint(x: newOffsetX, y: 0), animated: true)
            
        } else if tabOriginX + tabWidth > self.frame.size.width {
            // Trailing out of bounds
            let outOfBounds = self.frame.size.width - (tabOriginX + tabWidth)
            let padding = selectedTabIndex == (tabs.count - 1) ? appearance.contentInset : 10
            let newOffsetX = scrollView.contentOffset.x - outOfBounds + (padding ?? 10)
            scrollView.setContentOffset(CGPoint(x: newOffsetX, y: 0), animated: true)
        }
    }
}
