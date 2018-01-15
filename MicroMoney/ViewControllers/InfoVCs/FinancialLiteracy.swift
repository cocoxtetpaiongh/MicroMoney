//
//  FinancialLiteracy.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/17/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class FinancialLiteracy: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setText()
    }

    func setText() {
        
        let titleAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont(name: "Zawgyi-One", size: 21)!, NSAttributedStringKey.foregroundColor: UIColor.black]
        
        let titleString = NSAttributedString(string: "5 Articles to Refresh Your Financial Literacy By Jean Folger", attributes: titleAttribute)
        
        let titleDescAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont(name: "Zawgyi-One", size: 15)!, NSAttributedStringKey.foregroundColor: UIColor.black]
        
        let titleDesc = NSAttributedString(string: "5 Articles to Refresh Your Financial Literacy By Jean Folger", attributes: titleAttribute)


//        let titleAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: UIColor.red,
//                                                            NSAttributedStringKey.fo]
//        let titleString = "5 Articles to Refresh Your Financial Literacy By Jean Folger"
//        let titleStrin = NSAttributedString(string: "5 Articles to Refresh Your Financial Literacy By Jean Folger", attributes: titleAttribute)
    }
    
}






