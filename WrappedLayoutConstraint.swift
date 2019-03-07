//
//  WrappedLayoutConstraint.swift
//  dresscode
//
//  Created by HuyNguyen on 12/4/18.
//  Copyright © 2018 Savvycom. All rights reserved.
//

import UIKit

@IBDesignable
final class WrappedLayoutConstraint: NSLayoutConstraint {
    
    
    enum Scale: Int {
        case widthFactor // 0
        case heightFactor // 1
        case custom // 2
        case none // 3
    }
    
    private var _scale: Scale = .none
    //NOTE: storyboard always set default to false
    @IBInspectable var scaleIfFactorGreaterThanOne: Bool = false
    
    @IBInspectable var scale:Int {
        get {
            return self._scale.rawValue
        }
        set {
            self._scale = Scale(rawValue: newValue) ?? .none
        }
    }
    
    @IBInspectable var factor: CGFloat = 1
    
    override var constant: CGFloat {
        get {
            let factor: CGFloat
            switch self._scale {
            case .heightFactor:
                factor = UIScreen.main.bounds.height / 667 // zepline design with ip6
            case .widthFactor:
                factor = UIScreen.main.bounds.width / 375 // zepline design with ip6
            case .custom:
                factor = self.factor
            case .none:
                factor = 1
            }
            
            if factor > 1 && !scaleIfFactorGreaterThanOne {
                return super.constant
            } else {
                return super.constant * factor
            }
        }
        set {
            super.constant = newValue
        }
    }
    override init() {
        super.init()
    }
}
