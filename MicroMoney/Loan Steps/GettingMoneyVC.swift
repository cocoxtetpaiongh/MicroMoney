//
//  GettingMoneyVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import SwiftyJSON

class GettingMoneyVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var totalAmmountLabel: UILabel!
    @IBOutlet weak var repaymentDateLabel: UILabel!
    
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var accountNumberTextField: UITextField!
    @IBOutlet weak var iDTextField: UITextField!
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    @IBOutlet weak var totalAmmountDesc: UILabel!
    @IBOutlet weak var repaymentDateDesc: UILabel!
    @IBOutlet weak var paymentTypeDesc: UILabel!
    @IBOutlet weak var accountNumDesc: UILabel!
    @IBOutlet weak var idDesc: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!

    var paymentSystemList = [String]()
    var paymentSystemIDs = [String]()

    var paymentPicker = UIPickerView()
    
    var branchList = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getBranchLists()
//        getPaymentList()
    }
    
    func setText() {
        
        titleDescription.localize(with: "Getting money")
        infoDescription.localize(with: "ALMOST DONE! Please choose the bank and write your bank account number. If you not yet have bank account , you can continue this application later! Hurry to take your money!")
        
        totalAmmountDesc.localize(with: "Total Repayment amount")
        repaymentDateDesc.localize(with: "Repayment date")
        paymentTypeDesc.localize(with: "* Choose your bank or payment system here")
        accountNumDesc.localize(with: "* Fill your bank account number here")
        idDesc.localize(with: "* Your ID/ Passport Number")
        
        nextButton.localize(with: "Next")
        
    }
    
    func setupUI() {
        
        setText()
        
        repaymentDateLabel.text = UserInfo.user.repaymentDate
        totalAmmountLabel.text = UserInfo.user.RepayAmount
        
        paymentTextField.delegate = self
        accountNumberTextField.delegate = self
        iDTextField.delegate = self
        
        paymentTextField.inputView = paymentPicker
        
        paymentPicker.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.view.addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    func validate() {
        
        guard paymentTextField.text != "" else {
            
            Utlities.showAlert(with: "Empty Payment Stage", "Pick your payment state", "OK", self)
            
            paymentTextField.becomeFirstResponder()
            return
        }
        guard accountNumberTextField.text != "" else {
            
            Utlities.showAlert(with: "Empty Account Number", "Enter your account number", "OK", self)
            
            accountNumberTextField.becomeFirstResponder()
            return
        }
        guard iDTextField.text != "" else {
            
            Utlities.showAlert(with: "Empty ID/Passport", "Enter your passport number", "OK", self)
            
            iDTextField.becomeFirstResponder()
            return
        }
        
//        UserInfo.user.UsrPaySystemId = paymentTextField.text
        UserInfo.user.UsrPaySystemAccount = accountNumberTextField.text
        UserInfo.user.UsrMMPersonalID = iDTextField.text
        
        if paymentSystemList.isEmpty {
            
            UserInfo.user.UsrPaySystem = paymentTextField.text!
        }

        print(UserInfo.user, "Money Userinfo")
        
        gotoNextVC()
    }
    
    func gotoNextVC() {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentScanVC") as! DocumentScanVC
        
        navigationController?.pushViewController(nextVC, animated: true)

    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        validate()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }

}

extension GettingMoneyVC {
    
    func getBranchLists() {
        
        Utlities.showLoading(on: self.view, is: true)
        APIManager.share.getBranches { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self, completion: {
                    
                    self.navigationController?.popViewController(animated: true)
                })
                
                self.getPaymentList()
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parseBranchList(with: response)
                self.getPaymentList()
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self, completion: {
                    
                    self.navigationController?.popViewController(animated: true)
                })
                
                
            }
            
        }
        
    }
    
    func getPaymentList() {
        
        Utlities.showLoading(on: self.view, is: true)
        
        let branch = branchList[UserInfo.branch] ?? ""
        
        APIManager.share.getPaymentList(with: branch) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self, completion: {
                    
                    self.navigationController?.popViewController(animated: true)
                })
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parsePaymentList(with: response)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self, completion: {
                    
                    self.navigationController?.popViewController(animated: true)
                })
                
                
            }
            
        }
        
//        APIManager.share.getPaymentList { (response, status) in
//
//            print(response)
//
//            if response == JSON.null {
//
//                Utlities.showLoading(on: self.view, is: false)
//                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self, completion: {
//
//                    self.navigationController?.popViewController(animated: true)
//                })
//                return
//            }
//
//            if status == .Success {
//
//                Utlities.showLoading(on: self.view, is: false)
//                self.parsePaymentList(with: response)
//
//            } else {
//
//                Utlities.showLoading(on: self.view, is: false)
//                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self, completion: {
//
//                    self.navigationController?.popViewController(animated: true)
//                })
//
//
//            }
//
//        }
        
    }
    
    func parseBranchList(with json: JSON) {
        
        let data = json["d"]
        
        if data == JSON.null {
            
            Utlities.showLoading(on: self.view, is: false)
            Utlities.showAlert(with: "Error Loading Data", "Sorry, we cannot load payment list", "OK", self)
            
            //            return
        }
        
        let result = data["results"]
        
        branchList.removeAll()

        for payment in result.arrayValue {
            
            let account = payment["Name"].stringValue
            let id = payment["Id"].stringValue
            
            branchList[account] = id
            
        }
        
    }
    
    func parsePaymentList(with json: JSON) {
        
        let data = json["d"]
        
        if data == JSON.null {
            
            Utlities.showLoading(on: self.view, is: false)
            Utlities.showAlert(with: "Error Loading Data", "Sorry, we cannot load payment list", "OK", self)
            
//            return
        }
        
        let result = data["results"]
        
        paymentSystemList.removeAll()
        
        for payment in result.arrayValue {
            
            let account = payment["Name"].stringValue
            let id = payment["Id"].stringValue
            
            let description = payment["Description"].stringValue
            
            if description == "“**”" {
                
                paymentSystemIDs.append(id)
                paymentSystemList.append(account)

            }
            
//            paymentSystemIDs.append(id)
//            paymentSystemList.append(account)
        }
        
        paymentPicker.reloadAllComponents()
        
        if paymentSystemList.isEmpty {
            
            paymentTextField.inputView = nil 
        }
    }

}

extension GettingMoneyVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if paymentSystemList.isEmpty {
            
            return
        }
        
        let status = paymentSystemList[row]
        let payment = paymentSystemIDs[row]
        paymentTextField.text = status
        UserInfo.user.UsrPaySystemId = payment
        
    }
}

extension GettingMoneyVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return paymentSystemList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return paymentSystemList[row]
    }
}

extension GettingMoneyVC: UITextFieldDelegate {
    
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

