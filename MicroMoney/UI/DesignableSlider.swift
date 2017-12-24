//
//  DesignableSlider.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/17/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableSlider: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }

    @IBInspectable var thumbHightlightedImage: UIImage? {
        
        didSet {
            setThumbImage(thumbHightlightedImage, for: .highlighted)
        }
    }
}
