//
//  SlideMenuVC.swift
//  MingalarCinema
//
//  Created by Ye Myat Min on 12/1/17.
//  Copyright © 2017 nexlabs. All rights reserved.
//

import UIKit
import Localize_Swift

class SlideMenuVC: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    
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
                  "Token Sale"]
    
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
    
    func handleMenu(with tag: Int) {
        
//        if let view = recognizer.view {
        
            if tag == lastIndex {
                
                language = .English
                isLanguageChange = true
            } else if tag == lastIndex - 1 {
                
                language = .Myanmar
                isLanguageChange = true
            } else {
                
                language = .English
                isLanguageChange = false
            }
            
            menuSelected(with: tag)
//        }
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
            
            menuSelected(with: view.tag)
        }
    }
    
    func changeFont() {
        
        
    }
    
    func logOut() {
        
    }
    
    func showSetting() {
        
//        let settingVC = Storyboards.MovieList.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
//        present(settingVC, animated: true, completion: nil)
    }
    
    func showInfoViewControllers(_ index: Int = 0) {
        
        let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
        present(infoVC, animated: true, completion: nil)
    }
    
    func menuSelected(with index: Int) {
        
        if Localize.currentLanguage() == "my" {
            
            language = .Myanmar
        } else {
            
            language = .English
        }
        
        self.delegate?.didSelectMenu(at: index, and: self.isLanguageChange, with: self.language)

    }
    
    @IBAction func action(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            // DO Something
            
            changeFont()
            
        case 2:
            changeFont()
            
        case 3:
            showSetting()
            
        case 4:
            logOut()
            
        default:
            break
        }
    }
}

extension SlideMenuVC: UITableViewDataSource {
    
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
//        cell.label.addGestureRecognizer(gesture)
        cell.label.isUserInteractionEnabled = true
        cell.label.tag = indexPath.row
        cell.tag = indexPath.row
        return cell
    }
}

extension SlideMenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        guard !UserInfo.isUserSelectMenu else {
//            return
//        }
        
        UserInfo.isUserSelectMenu = true
        
//        print("Select \(indexPath.row)", "TableView Select")
//        menuSelected(with: indexPath.row)
        menuSelected(with: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

