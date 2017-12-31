//
//  EmploymentInfoVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class EmploymentInfoVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var socialStatusTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyNumberTextField: UITextField!
    @IBOutlet weak var incomTextField: UITextField!
    @IBOutlet weak var coworkerNumberTextField: UITextField!
    @IBOutlet weak var coworkerNameTextField: UITextField!
    
    var employeePicker = UIPickerView()
    
    var employStatus = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        socialStatusTextField.delegate = self
        companyNameTextField.delegate = self
        companyNumberTextField.delegate = self
        incomTextField.delegate = self
        coworkerNumberTextField.delegate = self
        coworkerNameTextField.delegate = self
        
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

        UserInfo.user.UsrOccupation = socialStatusTextField.text
        UserInfo.user.Account = companyNumberTextField.text
        UserInfo.user.UsrAccountName = companyNameTextField.text
        UserInfo.user.UsrSalaryAmount = Double(incomTextField.text!) 
        // coworker name
        // coworker number
        
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

