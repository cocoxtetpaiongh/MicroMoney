//
//  HomeViewController.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/6/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView! 
    
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

    @IBOutlet weak var cashAmmountSlider: UISlider!
    @IBOutlet weak var daysCountSlider: UISlider!
    
    var countryPicker = UIPickerView()
    
    var countryList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getCountryList()
    }
    
    func setupUI() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)

        cashAmmountView.layer.cornerRadius = 10
        repayAmountView.layer.cornerRadius = 10
        repayDateView.layer.cornerRadius = 10
        
        countryTextField.delegate = self
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryTextField.inputView = countryPicker
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.view.addGestureRecognizer(gesture)

    }
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func changeCashAmmount(_ sender: UISlider) {
        
        cashAmmountSlider.value = roundf(cashAmmountSlider.value)
    }
    
    @IBAction func changeDaysCount(_ sender: UISlider) {
        
        daysCountSlider.value = roundf(daysCountSlider.value)
    }
    
    @IBAction func menubuttonPressed(_ seneder: UIButton) {
        
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTableVC") as! MenuTableVC
        menuVC.delegate = self 
        present(menuVC, animated: false, completion: nil)
    }
    
    func getCountryList() {
        
        APIManager.share.getNationality { (response, status) in
            
            print(response)
            
            print("CountryData: \(response)")
            
            self.parseCountryList(with: response)
        }

    }

    func parseCountryList(with json: JSON) {
        
        let data = json["d"]
        
        let result = data["results"]
        
        for country in result.arrayValue {
            
            let name = country["Name"].stringValue
            
            countryList.append(name)
        }
        
        countryPicker.reloadAllComponents()
    }

    @IBAction func applyButtonPressed(_ sender: UIButton) {
        
        
        gotoNextVC()
        
        return 
        
        APIManager.share.applyLoan { (result, status) in
            
            print(result)
        }
    }
    
    func gotoNextVC() {
        
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
        } else if indexPath == 1 {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            present(infoVC, animated: true, completion: nil)
            
        } else {
            
            let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            
//            let webViewNavigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewNavigation") as! UINavigationController

            present(webView, animated: true, completion: nil)

        }
    }
}

extension HomeViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if countryList.isEmpty {
            
            return
        }
        
        let country = countryList[row]
        countryTextField.text = country
    }
}

extension HomeViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return countryList[row]
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 44
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        scrollView.contentOffset.y = textField.frame.origin.y
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
