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
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    @IBOutlet weak var emailDesc: UILabel!
    @IBOutlet weak var cityDesc: UILabel!
    @IBOutlet weak var birthdayDesc: UILabel!
    @IBOutlet weak var genderDesc: UILabel!
    @IBOutlet weak var numberDesc: UILabel!
    @IBOutlet weak var nationalDesc: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var countryList = [String]()
    var countryIDs = [String]()

    var cityList = [String]()
    var cityIDs = [String]()

    var birthdayPicker = UIDatePicker()
    var genderPicker = UIPickerView()
    var countryPicker = UIPickerView()
    var cityPicker = UIPickerView()
    
    var genderTypes = ["", "Male", "Female"]
    var genderIDs = ["", ""]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getCityList()
        getGenderList()
        getCountryList()
    }
    
    func setText() {
        
        titleDescription.localize(with: "Personal information")
        infoDescription.localize(with: "Please fill up the following fields. It is easy. We will appreciate if you fill in English. Fields indicated with * are mandatory.")

        cityDesc.localize(with: "* City")
        birthdayDesc.localize(with: "* BirthDay")
        genderDesc.localize(with: "* Gender")
        numberDesc.localize(with: "* Your Line or Whatsapp or Viber Phone number?")
        nationalDesc.localize(with: "* Nationality")
        
        nextButton.localize(with: "Next")
    }
    
    func setupUI() {
        
        setText()
        
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
//        cityTextField.inputView = cityPicker
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        var component = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        
        birthdayPicker.maximumDate = component
        
        component = Calendar.current.date(byAdding: .year, value: -40, to: Date())

        birthdayPicker.minimumDate = component
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        birthdayTextField.placeholder = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        UserInfo.user.UsrBirthDate = dateFormatter.string(from: Date())

        birthdayPicker.datePickerMode = .date
        birthdayPicker.addTarget(self, action: #selector(self.dateChange(_:)), for: .valueChanged)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.view.addGestureRecognizer(gesture)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
//        dateFormatter.dateStyle = .long
        birthdayTextField.text = dateFormatter.string(from: sender.date)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        UserInfo.user.UsrBirthDate = dateFormatter.string(from: sender.date)
    }

    func validate() {
        
//        guard emailTextField.text != "" else {
//            Utlities.showAlert(with: "Email is Empty", "Enter your email", "OK", self)
//            emailTextField.becomeFirstResponder()
//            return
//        }
        
        guard cityTextField.text != "" else {
            Utlities.showAlert(with: "City is Empty", "Enter your town", "OK", self)
            cityTextField.becomeFirstResponder()
            return
        }
        
        guard birthdayTextField.text != "" else {
            Utlities.showAlert(with: "Birthday is Empty", "Pick your birthdate", "OK", self)
            birthdayTextField.becomeFirstResponder()
            return
        }
        
        guard genderTextField.text != "" else {
            Utlities.showAlert(with: "Gender is Empty", "Chose Your Gender", "OK", self)
            genderTextField.becomeFirstResponder()
            return
        }
        
        guard nationalTextField.text != "" else {
            Utlities.showAlert(with: "Nationality is Empty", "Chose your nationality", "OK", self)
            nationalTextField.becomeFirstResponder()
            return
        }
        
        
        guard (numberTextField.text!.count <= 15)  else {
            Utlities.showAlert(with: "Please Enter your number no more than 15 characters", "", "OK", self)
            numberTextField.becomeFirstResponder()
            return
        }
        
        guard (numberTextField.text!.count >= 7)  else {
            Utlities.showAlert(with: "Please Enter your number at least 7 characters", "", "OK", self)
            numberTextField.becomeFirstResponder()
            return
        }

        
        UserInfo.user.Email = emailTextField.text
        UserInfo.user.CityId = cityTextField.text
//        UserInfo.user.MobilePhone = numberTextField.text

        print(UserInfo.user, "Personal Userinfo")
        
        gotoNextVC()
    }
    
    func gotoNextVC() {
        
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmploymentInfoVC") as! EmploymentInfoVC
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        validate()
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalInfoVC {
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    func getCityList() {
        
        Utlities.showLoading(on: self.view, is: true)
        APIManager.share.getCityList { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parseCityList(with: response)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
    func getGenderList() {
        
        Utlities.showLoading(on: self.view, is: true)
        APIManager.share.getGenderList { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parseGenderList(with: response)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
    func parseCityList(with json: JSON) {
        
        let data = json["d"]
        
        if data == JSON.null {
            
            Utlities.showLoading(on: self.view, is: false)
            Utlities.showAlert(with: "Error Loading Data", "Sorry, We cannot load city list", "OK", self)
            
//            return
        }

        let result = data["results"]
        
        cityList.removeAll()
        cityIDs.removeAll()
        
        for city in result.arrayValue {
            
            let name = city["Name"].stringValue
            let id = city["Id"].stringValue
            cityIDs.append(id)
            cityList.append(name)
        }
        
        genderPicker.reloadAllComponents()
    }

    
    func parseGenderList(with json: JSON) {
        
        let data = json["d"]
        
        if data == JSON.null {
            
            Utlities.showLoading(on: self.view, is: false)
            Utlities.showAlert(with: "Error Loading Data", "Sorry, We cannot load gender list", "OK", self)
            
//            return
        }

        
        let result = data["results"]
        
        genderTypes.removeAll()
        genderIDs.removeAll()
        
        for gender in result.arrayValue {
            
            let name = gender["Name"].stringValue
            let id = gender["Id"].stringValue
            genderIDs.append(id)
            genderTypes.append(name)
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
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parseCountryList(with: response)

            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Country Data", "OK", self)
                self.navigationController?.popViewController(animated: true)
            }

            
            
//            print("CountryData: \(response)")
//            
//            self.parseCountryList(with: response)
        }
        
    }
    
    func parseCountryList(with json: JSON) {
        
        let data = json["d"]
        
        if data == JSON.null {
            
            Utlities.showLoading(on: self.view, is: false)
            Utlities.showAlert(with: "Error Loading Data", "Sorry, We cannot load country load", "OK", self)
            
//            return
        }

        
        let result = data["results"]
        
        for country in result.arrayValue {
            
            let name = country["Name"].stringValue
            let id = country["Id"].stringValue
            
            countryIDs.append(id)
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
            UserInfo.user.GenderId = genderIDs[row]
            
        } else if pickerView == countryPicker {
            
            let country = countryList[row]
            nationalTextField.text = country
            UserInfo.user.UsrNationalityId = countryIDs[row]
        } else if pickerView == cityPicker {
            
            let city = cityList[row]
            cityTextField.text = city
            UserInfo.user.CityId = cityIDs[row]

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
        } else if pickerView == cityPicker {
            
            return cityList.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genderPicker {
            
            return genderTypes[row]
            
        } else if pickerView == countryPicker {
            
            return countryList[row]
        } else if pickerView == cityPicker {
            
            return cityList[row]
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

