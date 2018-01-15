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
import Localize_Swift
//import Localize_Swift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cashAdvanceAmmountDesc: UILabel!
    @IBOutlet weak var totalRepayAmmountDesc: UILabel!
    @IBOutlet weak var repayDateAmmountDesc: UILabel!
    
    @IBOutlet weak var fullNameDesc: UILabel!
    @IBOutlet weak var phoneDesc: UILabel!
    
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
    
    @IBOutlet weak var languageButton: UIButton! 

    @IBOutlet weak var cashAmmountSlider: UISlider!
    @IBOutlet weak var daysCountSlider: UISlider!
    
    @IBOutlet weak var ammountIndicatorLabel: UILabel!
    
    weak var slideMenuDelegate: SlideMenuDelegate?
    
    var countryPicker = UIPickerView()
    
    let overlayTag = 99
    
    var countryList = [String]()
    var countryIDs = [String]()
    
    var cashAmmount: Double = 0
    var period: Double = 0
    
    var cashAmmountList: [Double] = [30000, 50000, 80000, 100000, 130000, 150000, 200000]
//    var cashAmmountList = [30000, 50000, 80000, 100000, 130000, 150000, 200000]

    @IBAction func languageButtonPressed(_ sender: UIButton) {
        
        if languageButton.titleLabel?.text == "🇲🇲" {
            
            languageButton.setTitle("🇬🇧", for: .normal)
            Localize.resetCurrentLanguageToDefault()
            
        } else {
            
            languageButton.setTitle("🇲🇲", for: .normal)
            Localize.setCurrentLanguage("my")

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setText()
        setupUI()
        getCountryList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText() {
        
        ammountIndicatorLabel.text = "I NEED ".localized() + "\(Int(cashAmmount))" + " MMK ".localized() + " FOR ".localized() + "\(Int(period))" + " DAYS".localized()
        ammountIndicatorLabel.adjustLocaleFont()
        
//        cashAdvanceAmmountDesc.text = "Cash Advance Amount".localized()
//        totalRepayAmmountDesc.text = "Total Repayment amount".localized()
//        repayDateAmmountDesc.text = "Repayment date".localized()
        
        cashAdvanceAmmountDesc.localize(with: "Cash Advance Amount")
        totalRepayAmmountDesc.localize(with: "Total Repayment amount")
        repayDateAmmountDesc.localize(with: "Repayment date")
        
        fullNameDesc.text = "Full Name".localized()
//        fullNameDesc.adjustLocaleFont()
//        fullNameDesc.localize(with: "Full Name")
//        phoneDesc.text = "Phone".localized()
        phoneDesc.localize(with: "Phone")
//        applyButton.setTitle("APPLY TO GET LOAN NOW!".localized(), for: .normal)
        applyButton.localize(with: "APPLY TO GET LOAN NOW!")
        
//        "Cash Advance Amount" = "Cash Advance Amount";
//        "Total Repayment amount" = "Total Repayment amount";
//        "Repayment date" = "Repayment date";
//
//        "I am in" = "I am in";
//        "Full Name" = "Full Name";
//        "Phone" = "Phone";
//        "APPLY TO GET LOAN NOW!" = "APPLY TO GET LOAN NOW!";
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        
//        slideOverLay()
        slideMenuDelegate?.toggleSlideMenu()
    }
    
    func slideOverLay() {
        
        if let overlay = self.view.viewWithTag(overlayTag) {
            
            overlay.removeFromSuperview()
        } else {
            
            
            let overlayView = UIView()
            
            overlayView.frame = self.view.frame
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            
            overlayView.isUserInteractionEnabled = true
            
            overlayView.tag = overlayTag
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleSlider))
            overlayView.addGestureRecognizer(gesture)
            
            self.view.addSubview(overlayView)
            
        }
    }
    
    @objc func toggleSlider() {
        
        slideMenuDelegate?.toggleSlideMenu()
    }

    
    func setupUI() {
        
        languageButton.setTitle("🇬🇧", for: .normal)
        Localize.resetCurrentLanguageToDefault()

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
        
        scrollView.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        self.view.addGestureRecognizer(gesture)

        cashAmmount = cashAmmountList[0]
        period = 7 * 2
        
        UserInfo.user.UsrMoneyAmount = Int(cashAmmount)
        UserInfo.user.UsrTerm = Int(period)
        
        calculateCashAmmount(with: cashAmmount)
        calculateRepaymentDate(with: 2)
    
        calculateRepayMent()
        changeIndicatorLabel()
    }
    
    @objc func handleGesture(_ recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func changeCashAmmount(_ sender: UISlider) {
        
        cashAmmountSlider.value = roundf(cashAmmountSlider.value)
        
        let index = Int(cashAmmountSlider.value) - 1
        let ammount = cashAmmountList[index]
        UserInfo.user.UsrMoneyAmount = Int(ammount)
        
        
        calculateCashAmmount(with: ammount)
        
        self.cashAmmount = ammount
        changeIndicatorLabel()

        calculateRepayMent()
        
        print(UserInfo.user.UsrMoneyAmount)

    }
    
    func calculateCashAmmount(with ammount: Double) {
        
        cashAmountLabel.text = Int(ammount).description + " MMK".localized()
        cashAmountLabel.adjustLocaleFont()

    }
    
    func calculateRepayMent() {
        
        var loan = (period / 7) / 10
        loan += 1.2
        let repayment = (cashAmmount * loan)
        
        repayAmmountLabel.text = Int(repayment).description + " MMK".localized()
        repayAmmountLabel.adjustLocaleFont()
        
        UserInfo.user.RepayAmount = repayAmmountLabel.text
    }
    
    @IBAction func changeDaysCount(_ sender: UISlider) {
        
        daysCountSlider.value = roundf(daysCountSlider.value)
        
        let multplier = Double(daysCountSlider.value) + 1.0
        UserInfo.user.UsrTerm = Int(multplier * 7)
        
        self.period = multplier * 7
        calculateRepaymentDate(with: multplier)
        
        changeIndicatorLabel()
        
        calculateRepayMent()

        print(UserInfo.user.UsrTerm)
    }
    
    func changeIndicatorLabel() {
        
//        ammountIndicatorLabel.text = "I NEED \(Int(cashAmmount)) MMK FOR \(Int(period)) DAYS"
        ammountIndicatorLabel.text = "I NEED ".localized() + "\(Int(cashAmmount))" + " MMK ".localized() + " FOR ".localized() + "\(Int(period))" + " DAYS".localized()
        ammountIndicatorLabel.adjustLocaleFont()
    }
    
    func calculateRepaymentDate(with period: Double) {
        
        let unit: Set<Calendar.Component> = [.day, .month, .year]
        
        let value = Int(period) * 7
        let component = Calendar.current.date(byAdding: .day, value: value, to: Date())
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        repayDateLabel.text = formatter.string(from: component ?? Date())
        
        UserInfo.user.repaymentDate = formatter.string(from: component ?? Date()) + " (\(value))days "
    }
    
    
    
//    @IBAction func menubuttonPressed(_ seneder: UIButton) {
//        
//        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SlideMenuVC") as! SlideMenuVC
//        menuVC.delegate = self 
//        present(menuVC, animated: false, completion: nil)
//    }
    
    func getCountryList() {
        
        Utlities.showLoading(on: self.view, is: true)
        
        APIManager.share.getNationality { (response, status) in

            print(response)

            print("CountryData: \(response)")

            self.parseCountryList(with: response)

            Utlities.showLoading(on: self.view, is: false)

        }

//        APIManager.share.getCountryID { (response, status) in
//
//            print(response)
//
//            print("CountryData: \(response)")
//
//            self.parseCountryList(with: response)
//
//            Utlities.showLoading(on: self.view, is: false)
//
//        }

    }

    func parseCountryList(with json: JSON) {
        
        let data = json["d"]
        
        let result = data["results"]
        
        for country in result.arrayValue {
            
            let name = country["Name"].stringValue
            let id = country["Id"].stringValue
            
            if name == "Myanmar" {
                
                countryIDs.insert(id, at: 0)
                countryList.insert(name, at: 0)
            } else {
                countryIDs.append(id)
                countryList.append(name)
            }
        }
        
        if countryList.isEmpty {
            
            return
        }
        
        countryTextField.text = countryList[0]
        
        UserInfo.user.CountryId = countryIDs[0]
        
        countryPicker.reloadAllComponents()
    }

    @IBAction func applyButtonPressed(_ sender: UIButton) {
        
        guard nameTextField.text != "" else {
            Utlities.showAlert(with: "Your Name is Empty", "Enter Your Name", "Ok", self)
            nameTextField.becomeFirstResponder()
            return
        }
        
        guard phoneNumberTextField.text != "" else {
            Utlities.showAlert(with: "Your Phone Number is Empty", "Enter Your Number", "Ok", self)
            phoneNumberTextField.becomeFirstResponder()
            return
        }
        
        guard (phoneNumberTextField.text!.count <= 10)  else {
            Utlities.showAlert(with: "Please Enter your phone number no more than 10 characters", "", "OK", self)
            phoneNumberTextField.becomeFirstResponder()
            return
        }
        
        guard (phoneNumberTextField.text!.count >= 7)  else {
            Utlities.showAlert(with: "Please Enter your phone number at least 7 characters", "", "OK", self)
            phoneNumberTextField.becomeFirstResponder()
            return
        }

        
        UserInfo.user.Contact = nameTextField.text
        UserInfo.user.MobilePhone = phoneNumberTextField.text

        print(UserInfo.user, "Home Userinfo")
        
        let user = UserInfo.user
        
        debugPrint(user)
        
        print(user, "Home Userinfo")

        
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
    
    
    func didSelectMenu(at indexPath: Int, and isLanguageChange: Bool, with language: LocalizeLanguage) {
        
        if isLanguageChange {
            
            if language == .Myanmar {
                
                Localize.setCurrentLanguage("my")
//                UILabel.setLanguage(.Myanmar)

            } else {
                
                Localize.resetCurrentLanguageToDefault()
//                UILabel.setLanguage(.English)

//                Zawgyi-One
            }
            
            return
        }
        
        if indexPath == 0 {
            
            let infoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            present(infoVC, animated: true, completion: nil)
            
        } else if indexPath == -1 {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            present(infoVC, animated: true, completion: nil)
            
        } else {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            present(infoVC, animated: true, completion: nil)
            
        }

    }
    
    
    func didSelectMenu(at indexPath: Int) {
        
        if indexPath == 0 {
            
            let infoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            present(infoVC, animated: true, completion: nil)

//            self.navigationController?.pushViewController(menuVC, animated: true)
        } else if indexPath == -1 {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            present(infoVC, animated: true, completion: nil)
            
        } else {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            present(infoVC, animated: true, completion: nil)

//            let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//
//            present(webView, animated: true, completion: nil)

        }
    }
}

extension HomeViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if countryList.isEmpty {
            
            return
        }
        
        let country = countryList[row]
        UserInfo.user.UsrNationalityId = countryIDs[row]
        UserInfo.user.CountryId = countryIDs[row]

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

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.view.endEditing(true)
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

//extension HomeViewController: MenuDelegate {
//
//    func didSelectMenu(at indexPath: Int, and isLanguageChange: Bool, with language: LocalizeLanguage) {
//
//    }
//
//}

