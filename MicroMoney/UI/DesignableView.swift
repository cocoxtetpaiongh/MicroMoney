//
//  DesignableView.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 1/7/18.
//  Copyright © 2018 Coco Xtet Pai. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2.0 {
        
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.white {
        
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
}

@IBDesignable
class DesignableButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 2.0 {
        
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
}

