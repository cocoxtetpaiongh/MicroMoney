//
//  Extensions.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/6/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

extension UIFont {
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}


extension UITextView {
    
    func getAttributed(with string: String, and table: String? = nil) {
        
        let size = self.font?.pointSize ?? UIFont.labelFontSize
        
        if let table = table {
            
            self.text = text.localized(using: table)
            
        } else {
            
            self.text = text.localized()
        }
        
        if Localize.currentLanguage() == "my" {
            
            self.font = UIFont(name: "Zawgyi-One", size: size)
            
        } else {
            
            self.font = UIFont(name: "Arial_Bold", size: size)
        }
        
//        let titleFont = UIFont(name: self.font?.fontName, size: 30)
        
        let titleAttribute = [NSAttributedStringKey.font: self.font]
    }
}

extension UIButton {
    
    func localize(with text: String, and table: String? = nil) {
        
        let size = self.titleLabel?.font.pointSize ?? UIFont.buttonFontSize
        
        if let table = table {
            
            self.setTitle(text.localized(using: table), for: .normal)
            
        } else {
            
            self.setTitle(text.localized(), for: .normal)
        }
        
        if Localize.currentLanguage() == "my" {
            
            self.titleLabel?.font = UIFont(name: "Zawgyi-One", size: size)
            
        } else {
            
            self.titleLabel?.font = UIFont(name: "Arial_Bold", size: size)
        }
    }
}

extension UILabel {
    
    func localize(with text: String, and table: String? = nil) {
        
        let size = self.font.pointSize

        if let table = table {
            
            self.text = text.localized(using: table)

        } else {
            
            self.text = text.localized()
        }
        
        if Localize.currentLanguage() == "my" {
            
            self.font = UIFont(name: "Zawgyi-One", size: size)

        } else {
            
            self.font = UIFont(name: "Arial_Bold", size: size)
        }
        
        
    }
    
    func adjustLocaleFont() {
        
        let size = self.font.pointSize
        
        if Localize.currentLanguage() == "my" {
            
            self.font = UIFont(name: "Zawgyi-One", size: size)
        } else {
            
            self.font = UIFont(name: "Arial_Bold", size: size)
            
        }
    }
    
    func changeLanguage(with localizedString: String) {
        
        let size = self.font.pointSize

        if localizedString == "my" {
            
            self.font = UIFont(name: "Zawgyi-One", size: size)
        } else {
            
            self.font = UIFont(name: "Arial_Bold", size: size)

        }
        
    }
    
    class func setLanguage(_ language: LocalizeLanguage) {
        
        let size = self.appearance().font.pointSize
        
        if language == .Myanmar {
            
            self.appearance().font = UIFont(name: "Zawgyi-One", size: size)

        } else {
            
            self.appearance().font = UIFont(name: "Arial_Bold", size: size)
        }
        
    }
}
extension UIColor {
    
    class func colorFromHex(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
