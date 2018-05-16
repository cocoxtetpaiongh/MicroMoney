//
//  EmploymentInfoVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import Localize_Swift

class EmploymentInfoVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var socialStatusTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyNumberTextField: UITextField!
    @IBOutlet weak var incomTextField: UITextField!
    @IBOutlet weak var coworkerNumberTextField: UITextField!
    @IBOutlet weak var coworkerNameTextField: UITextField!
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    @IBOutlet weak var socialDesc: UILabel!
    @IBOutlet weak var companyNameDesc: UILabel!
    @IBOutlet weak var companyNumberDesc: UILabel!
    @IBOutlet weak var incomeDesc: UILabel!
    @IBOutlet weak var coworkerDesc: UILabel!
    @IBOutlet weak var coworkerNumberDesc: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var employeePicker = UIPickerView()
    
//    var employStatus = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setText() {

        titleDescription.localize(with: "Employment information")
        infoDescription.localize(with: "Please fill up the following fields. It is easy. We will appreciate if you fill in English. Fields indicated with * are mandatory.")
        
        socialDesc.localize(with: "Social Status")
        companyNameDesc.localize(with: "* Company Name")
        companyNumberDesc.localize(with: "* Company`s Phone Number")
        incomeDesc.localize(with: "* Monthly Gross Income (MMK)")
        coworkerNumberDesc.localize(with: "Your coworker phone number")
        coworkerDesc.localize(with: "coworker name")
        
        nextButton.localize(with: "Next")
        
        validateCurrency()
    }
    
    func validateCurrency() {
        
        guard Localize.currentLanguage() == LocalizeLanguage.English.rawValue else {
            return
        }
        
        switch UserInfo.branch {
            
        case BranchList.Myanmar.rawValue:
            
            incomeDesc.localize(with: "* Monthly Gross Income (MMK)")
            
            break
            
        case BranchList.Thailand.rawValue:
            
            incomeDesc.localize(with: "* Monthly Gross Income (THB)")
            
            break
        case BranchList.Indonesia.rawValue:
            
            incomeDesc.localize(with: "* Monthly Gross Income (IDR)")
            
            break
        case BranchList.Nigeria.rawValue:
            
            incomeDesc.localize(with: "* Monthly Gross Income (NGN)")

            break
        case BranchList.SriLankan.rawValue:
            
            incomeDesc.localize(with: "* Monthly Gross Income (Rs)")
            
            break
        case BranchList.Philippines.rawValue:
            
            incomeDesc.localize(with: "* Monthly Gross Income (PHP)")
            
            break
        default:
            
            incomeDesc.localize(with: "* Monthly Gross Income")
            
            break
        }
    }
    
    let employStatus = ["Business Owner",
                        "Self-Employment",
                        "Government Employee",
                        "House Wife",
                        "Police Military Employee",
                        "Unemployee",
                        "Attorney / Lawyer / Notary",
                        "Student",
                        "Pensioner",
                        "Staff",
                        "Manager",
                        "Director",
                        "Contract Employee",
                        "Office Worker"]
    
    func setupUI() {
        
        setText()
        
        employeePicker.dataSource = self
        employeePicker.delegate = self
        
        socialStatusTextField.delegate = self
        companyNameTextField.delegate = self
        companyNumberTextField.delegate = self
        incomTextField.delegate = self
        coworkerNumberTextField.delegate = self
        coworkerNameTextField.delegate = self
        
        socialStatusTextField.inputView = employeePicker
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.view.addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    func validate() {
        
        guard companyNameTextField.text != "" else {
            Utlities.showAlert(with: "No Company Name", "Enter your company name", "OK", self)
            companyNameTextField.becomeFirstResponder()
            return
        }
        
        guard companyNumberTextField.text != "" else {
            Utlities.showAlert(with: "No Company's Phone Number", "Enter your company's phone number", "OK", self)
            companyNumberTextField.becomeFirstResponder()
            return
        }
        
        guard incomTextField.text != "" else {
            Utlities.showAlert(with: "No Imcome Added", "Enter your income", "OK", self)
            incomTextField.becomeFirstResponder()
            return
        }

        guard (companyNumberTextField.text!.count <= 15)  else {
            Utlities.showAlert(with: "Please Enter your company phone number no more than 15 characters", "", "OK", self)
            companyNumberTextField.becomeFirstResponder()
            return
        }
        
        guard (companyNumberTextField.text!.count >= 7)  else {
            Utlities.showAlert(with: "Please Enter your company phone number at least 7 characters", "", "OK", self)
            companyNumberTextField.becomeFirstResponder()
            return
        }
        
        guard (coworkerNumberTextField.text!.count <= 15)  else {
            Utlities.showAlert(with: "Please Enter your coworker phone number no more than 15 characters", "", "OK", self)
            coworkerNumberTextField.becomeFirstResponder()
            return
        }
        
        guard (coworkerNumberTextField.text!.count >= 7)  else {
            Utlities.showAlert(with: "Please Enter your coworker phone number at least 7 characters", "", "OK", self)
            coworkerNumberTextField.becomeFirstResponder()
            return
        }

        UserInfo.user.UsrOccupation = socialStatusTextField.text
        UserInfo.user.Account = companyNameTextField.text
        UserInfo.user.UsrAccountName = companyNameTextField.text
        UserInfo.user.UsrSalaryAmount = Int(incomTextField.text!)
        
        UserInfo.user.CompanyName = companyNameTextField.text
        UserInfo.user.CompanyPhone = companyNumberTextField.text
        UserInfo.user.CoworkerName = coworkerNameTextField.text
        UserInfo.user.CoworkerPhone = coworkerNumberTextField.text
        
        // coworker name
        // coworker number
        
        print(UserInfo.user, "Employee Userinfo")
        
        gotoNextVC()
    }
    
    func gotoNextVC() {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GettingMoneyVC") as! GettingMoneyVC
        
        navigationController?.pushViewController(nextVC, animated: true)

    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        validate()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }

}

extension EmploymentInfoVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if employStatus.isEmpty {
            
            return
        }
        
        let status = employStatus[row]
        socialStatusTextField.text = status
        
    }
}

extension EmploymentInfoVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return employStatus.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return employStatus[row]
    }
}

extension EmploymentInfoVC: UITextFieldDelegate {
    
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

