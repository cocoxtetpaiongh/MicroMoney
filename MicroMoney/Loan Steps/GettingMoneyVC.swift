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

    var paymentSystemList = [String]()
    
    var paymentPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        paymentTextField.delegate = self
        accountNumberTextField.delegate = self
        iDTextField.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.view.addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentScanVC") as! DocumentScanVC
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }

}

extension GettingMoneyVC {
    
    func getPaymentList() {
        
        Utlities.showLoading(on: self.view, is: true)
        APIManager.share.getPaymentList { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                self.parsePaymentList(with: response)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
        
    }
    
    func parsePaymentList(with json: JSON) {
        
        let data = json["d"]
        
        let result = data["results"]
        
        paymentSystemList.removeAll()
        
        for payment in result.arrayValue {
            
            let account = payment["Name"].stringValue
            
            paymentSystemList.append(account)
        }
        
        paymentPicker.reloadAllComponents()
    }

}

extension GettingMoneyVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if paymentSystemList.isEmpty {
            
            return
        }
        
        let status = paymentSystemList[row]
        paymentTextField.text = status
        
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

