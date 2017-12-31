//
//  PersonalInfoVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalInfoVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var birthMonthTextField: UITextField!
    @IBOutlet weak var birthYearTextField: UITextField!

    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var nationalTextField: UITextField!
    
    var countryList = [String]()
    
    var birthdayPicker = UIDatePicker()
    var genderPicker = UIPickerView()
    var countryPicker = UIPickerView()
    
    var genderTypes = ["", "Male", "Female"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        getCountryList()
    }
    
    func setupUI() {
        
        emailTextField.delegate = self
        cityTextField.delegate = self
        birthdayTextField.delegate = self
        birthMonthTextField.delegate = self
        birthdayTextField.delegate = self
        
        genderTextField.delegate = self
        numberTextField.delegate = self
        nationalTextField.delegate = self
        
        birthdayTextField.inputView = birthdayPicker
        genderTextField.inputView = genderPicker
        nationalTextField.inputView = countryPicker
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        var component = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        
        birthdayPicker.maximumDate = component
        
        component = Calendar.current.date(byAdding: .year, value: -40, to: Date())

        birthdayPicker.minimumDate = component
        
        birthdayPicker.datePickerMode = .date
        birthdayPicker.addTarget(self, action: #selector(self.dateChange(_:)), for: .valueChanged)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.view.addGestureRecognizer(gesture)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
//        dateFormatter.dateStyle = .long
        birthdayTextField.text = dateFormatter.string(from: sender.date)
    }

    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmploymentInfoVC") as! EmploymentInfoVC
        
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalInfoVC {
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    func getGenderList() {
        
        Utlities.showLoading(on: self.view, is: true)
        APIManager.share.getGenderList { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parseGenderList(with: response)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
        
    }
    
    func parseGenderList(with json: JSON) {
        
        let data = json["d"]
        
        let result = data["results"]
        
        genderTypes.removeAll()
        
        for country in result.arrayValue {
            
            let gender = country["Name"].stringValue
            
            genderTypes.append(gender)
        }
        
        genderPicker.reloadAllComponents()
    }

    func getCountryList() {
        
        Utlities.showLoading(on: self.view, is: true)
        APIManager.share.getNationality { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parseCountryList(with: response)

            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Country Data", "OK", self)
            }

            
            
//            print("CountryData: \(response)")
//            
//            self.parseCountryList(with: response)
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

}

extension PersonalInfoVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if countryList.isEmpty || genderTypes.isEmpty {
            
            return
        }
        
        if pickerView == genderPicker {
            
            genderTextField.text = genderTypes[row]
            
        } else if pickerView == countryPicker {
            
            let country = countryList[row]
            nationalTextField.text = country
        }
        
    }
}

extension PersonalInfoVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == genderPicker {
            
            return genderTypes.count
        } else if pickerView == countryPicker {
            
            return countryList.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genderPicker {
            
            return genderTypes[row]
            
        } else if pickerView == countryPicker {
            
            return countryList[row]
        }

        return ""
//        return countryList[row]
    }
}

extension PersonalInfoVC: UITextFieldDelegate {
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

