//
//  FinishedVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import Localize_Swift

class FinishedVC: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var viberHotline1Label: UILabel!
    @IBOutlet weak var viberHotline2Label: UILabel!

    @IBOutlet weak var lineHotline1Label: UILabel!
    @IBOutlet weak var lineHotline2Label: UILabel!

    @IBOutlet weak var mobileHotline1Label: UILabel!
    @IBOutlet weak var mobileHotline2Label: UILabel!
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    
    @IBOutlet weak var successDesc: UILabel!
    @IBOutlet weak var messengerDesc: UILabel!
    @IBOutlet weak var viberDesc: UILabel!
    @IBOutlet weak var lineDesc: UILabel!
    @IBOutlet weak var hotLineDesc: UILabel!

    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setText()
    }

    func setText() {
        
        titleDescription.localize(with: "Success!")
//        infoDescription.localize(with: "ALMOST DONE! Please choose the bank and write your bank account number. If you not yet have bank account , you can continue this application later! Hurry to take your money!")
        
        messengerDesc.localize(with: "Send us message to FACEBOOK MESSENGER")
        viberDesc.localize(with: "Send message or call to Viber hotline:")
        lineDesc.localize(with: "Send message or call to LINE hotline:")
        hotLineDesc.localize(with: "Call Us on mobile hotline:")
        
        doneButton.localize(with: "Next")
    }

    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        
        var messengerURL = ""
        
        switch Localize.currentLanguage() {
        case LocalizeLanguage.English.rawValue:
            
            messengerURL = "https://www.messenger.com/t/micromoneymyanmar"

            break
            
        case LocalizeLanguage.Myanmar.rawValue:
            
            messengerURL = "https://www.messenger.com/t/micromoneymyanmar"

            break
            
        case LocalizeLanguage.Thailand.rawValue:
            
            messengerURL = "https://www.messenger.com/t/micromoneyth"

            break
            
        case LocalizeLanguage.Indonesia.rawValue:
            
            messengerURL = "https://www.messenger.com/t/micromoneyid"

            break
            
        case LocalizeLanguage.SriLanka.rawValue:
            
            messengerURL = "https://www.messenger.com/t/micromoneylk"

            break
            
        case LocalizeLanguage.Nigeria.rawValue:
            
            messengerURL = "https://www.messenger.com/t/micromoneyNG"

            break

        default:
            
            messengerURL = "https://www.messenger.com/t/micromoneymyanmar"

            break
        }
        
        guard messengerURL != "" else {
            return
        }
        
        if let url = URL(string: messengerURL) {
            
            if UIApplication.shared.canOpenURL(url) {
                
                UIApplication.shared.openURL(url)
            }

        }
        
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
//        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinishedVC") as! FinishedVC
//
//        navigationController?.pushViewController(nextVC, animated: true)
        
        navigationController?.popToRootViewController(animated: true)

    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
//        navigationController?.popViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }


}
