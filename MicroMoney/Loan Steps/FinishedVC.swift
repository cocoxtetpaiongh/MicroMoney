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
        setNumbers()
        addGestures()
    }

    func setText() {
        
        titleDescription.localize(with: "Success!")
//        infoDescription.localize(with: "ALMOST DONE! Please choose the bank and write your bank account number. If you not yet have bank account , you can continue this application later! Hurry to take your money!")
        
//        messengerDesc.localize(with: "Send us message to FACEBOOK MESSENGER")
//        messengerDesc.localize(with: "Send us message to FACEBOOK MESSENGER")
        messengerDesc.localizeAttrubute(with: "Send us message to FACEBOOK MESSENGER")
        viberDesc.localize(with: "Send message or call to Viber hotline:")
        lineDesc.localize(with: "Send message or call to LINE hotline:")
        hotLineDesc.localize(with: "Call Us on mobile hotline:")
        
        doneButton.localize(with: "Next")
    }
    
    func setNumbers() {
        
        switch UserInfo.branch {
        case BranchList.Myanmar.rawValue:

            break
            
        case BranchList.Thailand.rawValue:
            
            lineHotline1Label.text = "+66 63207 4103"
            lineHotline2Label.text = ""
            mobileHotline2Label.text = ""
            mobileHotline1Label.text = "+660 972 942 410\n+660 972 943 576\n+660 807 661 576\n+660 972 986 607"
            viberDesc.text = ""
            viberHotline1Label.text = ""
            viberHotline2Label.text = ""
            
            break
        case BranchList.Indonesia.rawValue:
            
            lineDesc.text = ""
            lineHotline1Label.text = ""
            lineHotline2Label.text = ""

            mobileHotline2Label.text = ""
            mobileHotline1Label.text = "+6281908600070"
            viberDesc.text = "Whatsapp"
            viberHotline1Label.text = "+6287888826434"
            viberHotline2Label.text = ""
            
            break
        case BranchList.Nigeria.rawValue:
            
            lineDesc.text = ""
            lineHotline1Label.text = ""
            lineHotline2Label.text = ""
            
            mobileHotline2Label.text = "contactus@micromoney.africa"
            mobileHotline1Label.text = "09082919700"
            viberDesc.text = ""
            viberHotline1Label.text = ""
            viberHotline2Label.text = ""

            break
        case BranchList.SriLankan.rawValue:
            
            lineDesc.text = ""
            lineHotline1Label.text = ""
            lineHotline2Label.text = ""
            
            mobileHotline2Label.text = ""
            mobileHotline1Label.text = "+947 127 409 53\n+947 127 403 51\n+947 127 414 69\n+947 128 041 06"
            viberDesc.text = ""
            viberHotline1Label.text = ""
            viberHotline2Label.text = ""
            
            break
        case BranchList.Philippines.rawValue:
            
            lineDesc.text = ""
            lineHotline1Label.text = ""
            lineHotline2Label.text = ""
            
            mobileHotline2Label.text = "9457917051"
            mobileHotline1Label.text = "9457917050"
            viberDesc.text = ""
            viberHotline1Label.text = ""
            viberHotline2Label.text = ""

            break
        default:
            
            lineDesc.text = ""
            lineHotline1Label.text = ""
            lineHotline2Label.text = ""
            
            mobileHotline2Label.text = ""
            mobileHotline1Label.text = ""
            viberDesc.text = ""
            viberHotline1Label.text = ""
            viberHotline2Label.text = ""
            
            break
        }
    }
    
    func addGestures() {
        
        let mobile1Gesture = UITapGestureRecognizer(target: self, action: #selector(makePhCall(_:)))
        
        mobileHotline1Label.addGestureRecognizer(mobile1Gesture)
        mobileHotline1Label.isUserInteractionEnabled = true
        
        let mobile2Gesture = UITapGestureRecognizer(target: self, action: #selector(makePhCall(_:)))
        
        mobileHotline2Label.addGestureRecognizer(mobile2Gesture)
        mobileHotline2Label.isUserInteractionEnabled = true

        let viber1Gesture = UITapGestureRecognizer(target: self, action: #selector(makePhCall(_:)))
        
        viberHotline1Label.addGestureRecognizer(viber1Gesture)
        viberHotline1Label.isUserInteractionEnabled = true
        
        let viber2Gesture = UITapGestureRecognizer(target: self, action: #selector(makePhCall(_:)))
        
        viberHotline2Label.addGestureRecognizer(viber2Gesture)
        viberHotline2Label.isUserInteractionEnabled = true

        
        let line2Gesture = UITapGestureRecognizer(target: self, action: #selector(makePhCall(_:)))
        
        lineHotline2Label.addGestureRecognizer(line2Gesture)
        lineHotline2Label.isUserInteractionEnabled = true
        
        let line1Gesture = UITapGestureRecognizer(target: self, action: #selector(makePhCall(_:)))
        
        lineHotline1Label.addGestureRecognizer(line1Gesture)
        lineHotline1Label.isUserInteractionEnabled = true
        
    }
    
    @objc func makePhCall(_ recognizer: UITapGestureRecognizer) {
        
        guard let label = recognizer.view as? UILabel else {
            
            return
        }
        
        guard let number = label.text?.replacingOccurrences(of: " ", with: "") else {
            
            return
        }
        
        if let url = URL(string: "tel://\(number)") {
            
            if(UIApplication.shared.canOpenURL(url)) {
                
                UIApplication.shared.openURL(url)
            }
        }

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
