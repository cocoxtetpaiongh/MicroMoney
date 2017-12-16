//
//  HomeViewController.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/6/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var cashAmountLabel: UILabel!
    @IBOutlet weak var repayAmmountLabel: UILabel!
    @IBOutlet weak var repayDateLabel: UILabel!

    @IBOutlet weak var cashAmmountView: UIView!
    @IBOutlet weak var repayAmountView: UIView!
    @IBOutlet weak var repayDateView: UIView!

    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    @IBOutlet weak var applyButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        cashAmmountView.layer.cornerRadius = 10
        repayAmountView.layer.cornerRadius = 10
        repayDateView.layer.cornerRadius = 10
        
        countryTextField.delegate = self
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    @IBAction func menubuttonPressed(_ seneder: UIButton) {
        
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTableVC") as! MenuTableVC
        menuVC.delegate = self 
        present(menuVC, animated: false, completion: nil)
    }

    @IBAction func applyButtonPressed(_ sender: UIButton) {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalInfoVC") as! PersonalInfoVC
        
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
}

extension HomeViewController: MenuDelegate {
    
    func didSelectMenu(at indexPath: Int) {
        
        if indexPath == 0 {
            
            let infoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            present(infoVC, animated: true, completion: nil)

//            self.navigationController?.pushViewController(menuVC, animated: true)
        } else {
            
            let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            
//            let webViewNavigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewNavigation") as! UINavigationController

            present(webView, animated: true, completion: nil)

        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
