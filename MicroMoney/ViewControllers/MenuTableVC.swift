//
//  MenuTableVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/6/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

enum LocalizeLanguage: String {
    case Myanmar = "my"
    case English = "en"
    case Thailand = "th_TH"
    case Indonesia = "id"
    case SriLanka = "ta_LK"
    case Nigeria = "yo_NG"
}

protocol MenuDelegate: class {
    
//    func didSelectMenu(at indexPath: Int)
    func didSelectMenu(at indexPath: Int, and isLanguageChange: Bool, with language: LocalizeLanguage)
}

class MenuTableVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MenuDelegate?
    
    var titles = ["Home",
                  "About Micromoney",
                  "Financial Literacy",
                  "Apply Online for Cash Advance",
                  "Prolongation",
                  "Cash Repayment",
                  "FAQs",
                  "Contat Us",
                  "Carrers",
                  "Token Sale",
                  "Language: 🇬🇧 -> 🇲🇲",
                  "Language: 🇲🇲 -> 🇬🇧"]
    
    var isLanguageChange = false
    var isLocalize = false
    
    var lastIndex = 0
    
    var language: LocalizeLanguage = .English

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self 
    }
    
    func dismissAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuButtonPressed() {
        
        dismissAction()
    }
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        if let view = recognizer.view {
            
            if view.tag == lastIndex {
                
                language = .English
                isLanguageChange = true
            } else if view.tag == lastIndex - 1 {
                
                language = .Myanmar
                isLanguageChange = true
            } else {
                
                language = .English
                isLanguageChange = false
            }
            
            dismiss(animated: false, completion: {
                
                self.delegate?.didSelectMenu(at: view.tag, and: self.isLanguageChange, with: self.language)
            })
            
        }
    }

}

extension MenuTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        if indexPath.row == indexPath.last {
            
            isLanguageChange = true
            
            if isLocalize {
                
                titles.removeLast()
                titles.append("Language: 🇲🇲 -> 🇬🇧")
                isLocalize = !isLocalize

            } else {
                
                titles.removeLast()
                titles.append("Language: 🇬🇧 -> 🇲🇲")
                isLocalize = !isLocalize
            }
            
        } else {
            
            isLanguageChange = false
        }
 */
        
        lastIndex = indexPath.last ?? 0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.label.text = titles[indexPath.row]
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        cell.label.addGestureRecognizer(gesture)
        cell.label.isUserInteractionEnabled = true
        cell.label.tag = indexPath.row
        return cell
    }
}

extension MenuTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:
        
//        dismiss(animated: false, completion: {
//
//            self.delegate?.didSelectMenu(at: indexPath.row)
//        })
        
//        delegate?.didSelectMenu(at: indexPath.row)
//        dismissAction()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
