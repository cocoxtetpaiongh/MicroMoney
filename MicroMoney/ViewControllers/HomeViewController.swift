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
import CoreLocation
import Contacts
import ContactsUI
import FBSDKCoreKit
import FBSDKLoginKit

//import FBSDKLoginManager
//import FBSDKGraphRequest

//import Localize_Swift

//enum ContactsFilter {
//    case none
//    case mail
//    case message
//}

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

    @IBOutlet weak var cashAMmountContainerView: UIStackView!
    
    @IBOutlet weak var firstLoanLabel: UILabel!

    weak var slideMenuDelegate: SlideMenuDelegate?
    
    var locationManager: CLLocationManager!
    
    var phoneContacts = [PhoneContacts]() // array of PhoneContact
    var filter: ContactsFilter = .none
    
    
    var currentCountry = ""
    
    var countryPicker = UIPickerView()
    
    let overlayTag = 99
    
    var countryList = [String]()
    var countryIDs = [String]()
    
    var cashAmmount: Double = 0
    var period: Double = 0
    
    var cashAmmountList: [Double] = [30000, 50000, 80000, 100000, 130000, 150000, 200000, 300000]
//    var cashAmmountList = [30000, 50000, 80000, 100000, 130000, 150000, 200000]

    @IBAction func languageButtonPressed(_ sender: UIButton) {
        
//        if languageButton.titleLabel?.text == "🇲🇲" {
//
//            languageButton.setTitle("🇬🇧", for: .normal)
//            Localize.resetCurrentLanguageToDefault()
//
//        } else {
//
//            languageButton.setTitle("🇲🇲", for: .normal)
//            Localize.setCurrentLanguage("my")
//
//        }
        
        switch currentCountry {
        case CountryList.Myanmar.rawValue:
            
            if languageButton.titleLabel?.text == LocalizeLabel.Myanmar.rawValue {
                
                languageButton.setTitle("🇬🇧", for: .normal)
                Localize.resetCurrentLanguageToDefault()
            } else {
                
                languageButton.setTitle("🇲🇲", for: .normal)
                Localize.setCurrentLanguage("my")
            }
            break
            
        case CountryList.Philippines.rawValue:
            
            if languageButton.titleLabel?.text == LocalizeLabel.Philippines.rawValue {
                
                languageButton.setTitle("🇬🇧", for: .normal)
                Localize.resetCurrentLanguageToDefault()
            } else {
                
                languageButton.setTitle(LocalizeLabel.Philippines.rawValue, for: .normal)
                Localize.setCurrentLanguage(LocalizeLanguage.Philippines.rawValue)
            }
            break
            
        case CountryList.Thailand.rawValue:
            
            if languageButton.titleLabel?.text == LocalizeLabel.Thailand.rawValue {
                
//                languageButton.setTitle("🇬🇧", for: .normal)
//                Localize.resetCurrentLanguageToDefault()
                
                languageButton.setTitle(LocalizeLabel.Myanmar.rawValue, for: .normal)
                Localize.setCurrentLanguage(LocalizeLanguage.Myanmar.rawValue)

                
            } else if languageButton.titleLabel?.text == LocalizeLabel.Default.rawValue {
                
//                languageButton.setTitle(LocalizeLabel.Myanmar.rawValue, for: .normal)
//                Localize.setCurrentLanguage(LocalizeLanguage.Myanmar.rawValue)
                
                languageButton.setTitle(LocalizeLabel.Thailand.rawValue, for: .normal)
                Localize.setCurrentLanguage(LocalizeLanguage.Thailand.rawValue)

            } else {
                
//                languageButton.setTitle(LocalizeLabel.Thailand.rawValue, for: .normal)
//                Localize.setCurrentLanguage(LocalizeLanguage.Thailand.rawValue)
                
                languageButton.setTitle("🇬🇧", for: .normal)
                Localize.resetCurrentLanguageToDefault()

            }

            break
            
        case CountryList.Indonesia.rawValue:
            
            if languageButton.titleLabel?.text == LocalizeLabel.Indonesia.rawValue {
                
                languageButton.setTitle("🇬🇧", for: .normal)
                Localize.resetCurrentLanguageToDefault()
            } else {
                
                languageButton.setTitle(LocalizeLabel.Indonesia.rawValue, for: .normal)
                Localize.setCurrentLanguage(LocalizeLanguage.Indonesia.rawValue)
            }
            break
            
        case CountryList.SriLankan.rawValue:
            
            if languageButton.titleLabel?.text == LocalizeLabel.SriLankan.rawValue {
                
                languageButton.setTitle("🇬🇧", for: .normal)
                Localize.resetCurrentLanguageToDefault()
            } else {
                
                languageButton.setTitle(LocalizeLabel.SriLankan.rawValue, for: .normal)
                Localize.setCurrentLanguage(LocalizeLanguage.SriLanka.rawValue)
            }
            break
            
        case CountryList.Nigeria.rawValue:
            
            if languageButton.titleLabel?.text == LocalizeLabel.Nigeria.rawValue {
                
                languageButton.setTitle("🇬🇧", for: .normal)
                Localize.resetCurrentLanguageToDefault()
            } else {
                
                languageButton.setTitle(LocalizeLabel.Nigeria.rawValue, for: .normal)
                Localize.setCurrentLanguage(LocalizeLanguage.Nigeria.rawValue)
            }
            break
            
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
//        self.view.addSubview(loginButton)
        
        if let token =  FBSDKAccessToken.current() {
            
            // User is logged in, do work such as go to next view controller.

        }
        
        loginButton.readPermissions = ["public_profile", "email"]
        
        firstLoanLabel.text = ""

        setText()
        setupUI()
        getCountryList()
        
        getLocation()
        
        
//        print(contacts.first, "Phone Number First")
    }
    
    func getLocation() {
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
//    func loadContacts(filter: ContactsFilter) {
//        phoneContacts.removeAll()
//        var allContacts = [PhoneContacts]()
//        for contact in PhoneContacts.getContacts(filter: filter) {
////            allContacts.append(PhoneContacts(contact: contact))
////            allContacts.append(contact)
//        }
//
//        var filterdArray = [PhoneContacts]()
//        if self.filter == .mail {
//            filterdArray = allContacts.filter({ $0.email.count > 0 }) // getting all email
//        } else if self.filter == .message {
//            filterdArray = allContacts.filter({ $0.phoneNumber.count > 0 })
//        } else {
//            filterdArray = allContacts
//        }
//        phoneContacts.append(contentsOf: filterdArray)
//        DispatchQueue.main.async {
////            self.tableView.reloadData()
//        }
//    }
    
    func contantLists() -> [[String: Any]] {
        
        let contacts = PhoneContacts.getContacts() // here calling the getContacts methods
        
        var phoneContacts = [[String: Any]]()
        
        var arrPhoneNumbers = [String]()
        var arrMails = [String]()
        
        for contact in contacts {
            
            for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
                if let fulMobNumVar  = ContctNumVar.value as? CNPhoneNumber {
                    //let countryCode = fulMobNumVar.value(forKey: "countryCode") get country code
                    if let MccNamVar = fulMobNumVar.value(forKey: "digits") as? String {
                        arrPhoneNumbers.append(MccNamVar)
                    }
                }
            }
            
            for email in contact.emailAddresses {
                
                if let address = email.value as? String {
                    
                    arrMails.append(address)
                }
            }
            
            
            
            let name = contact.givenName
            
            var phoneContact = [String: Any]()
            
            phoneContact["phoneNumbers"] = arrPhoneNumbers.first
            phoneContact["emailAddresses"] = arrMails.first
            phoneContact["name"] = name
            
            phoneContacts.append(phoneContact)
            
        }
        
        return phoneContacts // here array has all contact numbers.
    }

    func phoneNumberAndEmails() -> [String: Any] {
        
        let contacts = PhoneContacts.getContacts() // here calling the getContacts methods
        
        var phoneContacts = [String: Any]()
        
        var arrPhoneNumbers = [String]()
        var arrMails = [String]()
        
        for contact in contacts {
            
            for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
                if let fulMobNumVar  = ContctNumVar.value as? CNPhoneNumber {
                    //let countryCode = fulMobNumVar.value(forKey: "countryCode") get country code
                    if let MccNamVar = fulMobNumVar.value(forKey: "digits") as? String {
                        arrPhoneNumbers.append(MccNamVar)
                    }
                }
            }
            
            for email in contact.emailAddresses {
                
                if let address = email.value as? String {
                    
                    arrMails.append(address)
                }
            }
            
            
            
            let name = contact.givenName
            
            phoneContacts["phoneNumbers"] = arrPhoneNumbers.first
            phoneContacts["emailAddresses"] = arrMails.first
            phoneContacts["name"] = name
            
        }
        return phoneContacts // here array has all contact numbers.
    }
    
//    fileprivate func loadContacts(filter: ContactsFilter) {
//        phoneContacts.removeAll()
//        var allContacts = [PhoneContacts]()
//        for contact in PhoneContacts.getContacts(filter: filter) {
//            allContacts.append(phoneContacts(contact: contact))
//        }
//
//        var filterdArray = [phoneContacts]
//        if self.filter == .mail {
//            filterdArray = allContacts.filter({ $0.email.count > 0 }) // getting all email
//        } else if self.filter == .message {
//            filterdArray = allContacts.filter({ $0.phoneNumber.count > 0 })
//        } else {
//            filterdArray = allContacts
//        }
//        phoneContacts.append(contentsOf: filterdArray)
////        DispatchQueue.main.async {
////            self.tableView.reloadData()
////        }
//    }

//    func loginToFacebook() {
//
//        let loginManager = FBSDKLoginManager()
//
//        loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: {
//            result, error in
//
//            guard error == nil else { return }
//
//            guard let result = result else { return }
//
//            if result.isCancelled {
//
//                print("Cancelled")
//            } else {
//
//                print(result)
//
//                self.getFBUserInfo()
//
//            }
//        })
//
//    }
    
//    func getFBUserInfo() {
//        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email,birthday,gender,name"]) // ,picture.type(large)"])
//        
//        Utlities.showLoading(on: self.view, is: true)
//        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
//            
//            if ((error) != nil)
//            {
//                print("Error: \(String(describing: error))")
//                Utlities.showLoading(on: self.view, is: false)
//            }
//            else
//            {
//                let data:[String: AnyObject] = result as! [String : AnyObject]
//                print(data)
//                
//                if let name = data["name"] as? String {
//                    
//                    self.nameTextField.text = name
//                }
//                
//                if let gender = data["gender"] as? String {
//                    
//                    self.genderTextField.text = gender.capitalized
//                }
//                
//                if let birthday = data["birthday"] as? String {
//                    
//                    self.birthdayTextField.text = birthday.replacingOccurrences(of: "/", with: "-")
//                }
//                
//                if let email = data["email"] as? String {
//                    
//                    self.emailTextField.text = email
//                }
//                
//                self.userInfo.name = self.nameTextField.text ?? ""
//                self.userInfo.gender = self.genderTextField.text ?? ""
//                self.userInfo.birthday = self.birthdayTextField.text ?? ""
//                self.userInfo.email = self.emailTextField.text
//                
//                self.gotoDetail()
//                
//                Utlities.showLoading(on: self.view, is: false)
//            }
//        })
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText() {
        
        let currency = UserInfo.getLocalizedCurrency(with: currentCountry)
//        ammountIndicatorLabel.text = "I NEED ".localized() + "\(Int(cashAmmount))" + " MMK ".localized() + " FOR ".localized() + "\(Int(period))" + " DAYS".localized()
        
        ammountIndicatorLabel.text = "I NEED ".localized() + "\(Int(cashAmmount))" + " " + currency + " FOR ".localized() + "\(Int(period))" + " DAYS".localized()

        ammountIndicatorLabel.adjustLocaleFont()
        
//        cashAdvanceAmmountDesc.text = "Cash Advance Amount".localized()
//        totalRepayAmmountDesc.text = "Total Repayment amount".localized()
//        repayDateAmmountDesc.text = "Repayment date".localized()
        
        cashAdvanceAmmountDesc.localize(with: "Cash Advance Amount")
        totalRepayAmmountDesc.localize(with: "Total Repayment amount")
//        totalRepayAmmountDesc.localize(with: "Total Repayment amount Total Repayment amount")
        repayDateAmmountDesc.localize(with: "Repayment date")
        
//        fullNameDesc.text = "Full Name".localized()
        
//        fullNameDesc.adjustLocaleFont()
        fullNameDesc.localize(with: "Full Name")
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
        
//        cashAmmountSlider.addTarget(self, action: #selector(cashAmmountSlider(valueChanged:)), for: UIControlEventAllEvents)
        
        cashAmmountSlider.addTarget(self, action: #selector(cashAmmountSlider(valueChanged:)), for: UIControlEvents.allEvents)
        
        daysCountSlider.addTarget(self, action: #selector(daysCountSlider(valueChanged:)), for: UIControlEvents.allEvents)

        setDefaults()
    }
    
    func setDefaults() {
        
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
    
    func updateCashAmmount() {
        
        for subView in cashAMmountContainerView.subviews.enumerated() {
            
            if let label = subView.element as? UILabel {
                
                let ammount = Int(cashAmmountList[subView.offset])
                label.text = ammount.description
            }
        }
    }
    
    @objc func daysCountSlider(valueChanged sender: UISlider) {
        
        let dayCountValue = roundf(daysCountSlider.value)
        
        daysCountSlider.setValue(dayCountValue, animated: true)

        let multplier = Double(daysCountSlider.value) + 1.0
        UserInfo.user.UsrTerm = Int(multplier * 7)
        
        self.period = multplier * 7
        calculateRepaymentDate(with: multplier)
        
        changeIndicatorLabel()
        
        calculateRepayMent()
        
        print(UserInfo.user.UsrTerm)
    }
    
    @objc func cashAmmountSlider(valueChanged sender: UISlider) {
        
        //        cashAmmountSlider.value = roundf(cashAmmountSlider.value)
        
//        if !UserInfo.isUserAlreadyLoan() {
//
//            firstLoanLabel.text = "This amount is available to repeat borrowers only"
//
//        } else {
//
//            firstLoanLabel.text = ""
//        }
        
        let cashAmmountValue = roundf(cashAmmountSlider.value)
        
        cashAmmountSlider.setValue(cashAmmountValue, animated: true)
        
        print(cashAmmountSlider.value, "Cash Value")
        
        let index = Int(cashAmmountSlider.value) - 1
        let ammount = cashAmmountList[index]
        UserInfo.user.UsrMoneyAmount = Int(ammount)
        
        if index > 1 {
            
            if !UserInfo.isUserAlreadyLoan() {
                
                firstLoanLabel.text = "This amount is available to repeat borrowers only"
                
            } else {
                
                firstLoanLabel.text = ""
            }

        } else {
            
            firstLoanLabel.text = ""
        }
        
        calculateCashAmmount(with: ammount)
        
        self.cashAmmount = ammount
        changeIndicatorLabel()
        
        calculateRepayMent()
        
        print(UserInfo.user.UsrMoneyAmount)
        
    }
    
    @IBAction func changeCashAmmount(_ sender: UISlider) {
        
//        cashAmmountSlider.value = roundf(cashAmmountSlider.value)
        let cashAmmountValue = roundf(cashAmmountSlider.value)
        
        cashAmmountSlider.setValue(cashAmmountValue, animated: true)

        print(cashAmmountSlider.value, "Cash Value")
        
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
        
        if countryTextField.text == CountryList.Thailand.rawValue {
            
            cashAmountLabel.text = Int(ammount).description + " THB".localized()

        }
        cashAmountLabel.adjustLocaleFont()

    }
    
    func calculateRepayMent() {
        
        var loan: Double = 0
//        var loan = (period / 7) / 10
//        loan += 1.2
//        let repayment = (cashAmmount * loan)
        
        loan = (cashAmmount / 100) * period

        if Localize.currentLanguage() == LocalizeLanguage.Indonesia.rawValue || Localize.currentLanguage() == LocalizeLanguage.SriLanka.rawValue {
            
            loan = (cashAmmount * 2 / 100) * period

        }
        
        let repayment = (cashAmmount + loan)
        
        repayAmmountLabel.text = Int(repayment).description + " MMK".localized()
        
        if countryTextField.text == CountryList.Thailand.rawValue {
            
            repayAmmountLabel.text = Int(repayment).description + " THB".localized()

        }
        
        repayAmmountLabel.adjustLocaleFont()
        
        UserInfo.user.RepayAmount = repayAmmountLabel.text
        
        repayAmmountLabel.text = ""

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
        
        if countryTextField.text == CountryList.Thailand.rawValue {
            
            ammountIndicatorLabel.text = "I NEED ".localized() + "\(Int(cashAmmount))" + " THB ".localized() + " FOR ".localized() + "\(Int(period))" + " DAYS".localized()

        }
        
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
    
    func reloadCountry() {
        
        getCountryList()
    }
    
    func getCountryList() {
        
        Utlities.showLoading(on: self.view, is: true)
        
        APIManager.share.getNationality { (response, status) in

            print(response)

            print("CountryData: \(response)")
            
            guard status == .Success else {
                
                Utlities.showLoading(on: self.view, is: false)

                Utlities.showAlert(with: "Something went wrong", "cannot get country list", "Retry", self, completion: {
                    self.reloadCountry()

                })
                return
            }

            self.parseCountryList(with: response)

            Utlities.showLoading(on: self.view, is: false)

        }


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
            } else if name != "Cambodian" && name != "Zambianian" && name != "Lao" && name != "Mexican" && name != "Cameroonian"{
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
        
        guard (phoneNumberTextField.text!.count <= 15)  else {
            Utlities.showAlert(with: "Please Enter your phone number no more than 15 characters", "", "OK", self)
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
        
        self.gotoNextVC()

        /*

        print(UserInfo.user, "Home Userinfo")
        
        let user = UserInfo.user
        
        debugPrint(user)
        
        print(user, "Home Userinfo")

        let contacts = phoneNumberAndEmails()["name"]
        
        let phoneContatcs = contantLists()
        
        let name = phoneNumberAndEmails()["name"] ?? ""
        let phoneNumbers = phoneNumberAndEmails()["phoneNumbers"] ?? ""
        let emailAddresses = phoneNumberAndEmails()["emailAddresses"] ?? ""
        
        let location = UserInfo.user.UsrGps ?? ""
        
        let parameters: [AnyHashable: Any] = ["name": name,
                                              "emailAddresses": emailAddresses,
                                              "location": location]


        FBSDKAppEvents.logEvent(UserInfo.user.MobilePhone, parameters: parameters)
        
        Utlities.showLoading(on: self.view, is: true)
        
        let contact: [String : Any] = ["Name": name,
                                       "Email": emailAddresses,
                                       "Phone": phoneNumbers]
        
        APIManager.share.addContacts(with: contact) { (result, status) in
            
            Utlities.showLoading(on: self.view, is: false)
            self.gotoNextVC()
        }
        
//        gotoNextVC()
        
        return 
        
        APIManager.share.applyLoan { (result, status) in
            
            print(result)
        }
        
        */
    }
    
    func gotoNextVC() {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalInfoVC") as! PersonalInfoVC
        
        navigationController?.pushViewController(nextVC, animated: true)

    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        print("User Location", location.coordinate.latitude, location.coordinate.longitude)
        
        UserInfo.user.UsrGps = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
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
//            present(infoVC, animated: true, completion: nil)
            navigationController?.pushViewController(infoVC, animated: true)
            
        } else if indexPath == -1 {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            navigationController?.pushViewController(infoVC, animated: true)

        } else {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            navigationController?.pushViewController(infoVC, animated: true)

        }

    }
    
    
    func didSelectMenu(at indexPath: Int) {
        
        if indexPath == 0 {
            
            let infoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
//            present(infoVC, animated: true, completion: nil)

            self.navigationController?.pushViewController(infoVC, animated: true)
            
        } else if indexPath == -1 {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            navigationController?.pushViewController(infoVC, animated: true)

        } else {
            
            let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
            navigationController?.pushViewController(infoVC, animated: true)

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
        
        validateLanguage()
        
        currentCountry = countryTextField.text ?? ""
    }
    
    func validateLanguage() {
        
        guard countryTextField.text != currentCountry else {
            return
        }
        
        guard let country = countryTextField.text else {
            
            return
        }
        
        switch country {
        case CountryList.Myanmar.rawValue:
            languageButton.setTitle("🇲🇲", for: .normal)
            Localize.setCurrentLanguage(LocalizeLanguage.Myanmar.rawValue)
            cashAmmountList = [30000, 50000, 80000, 100000, 130000, 150000, 200000, 300000]

            UserInfo.branch = BranchList.Myanmar.rawValue
            break
            
        case CountryList.Thailand.rawValue:
            languageButton.setTitle(LocalizeLabel.Default.rawValue, for: .normal)
            Localize.setCurrentLanguage(LocalizeLanguage.English.rawValue)

//            languageButton.setTitle("🇹🇭", for: .normal)
//            Localize.setCurrentLanguage(LocalizeLanguage.Thailand.rawValue)
////            Localize.setCurrentLanguage("th")
            cashAmmountList = [200000, 400000, 800000, 1000000, 1350000, 1500000, 2000000, 300000]
            UserInfo.branch = BranchList.Thailand.rawValue
            break
            
        case CountryList.Indonesia.rawValue:
            languageButton.setTitle("🇮🇩", for: .normal)
            Localize.setCurrentLanguage(LocalizeLanguage.Indonesia.rawValue)
            cashAmmountList = [1000, 2000, 3000, 4000, 5000, 7000, 9000, 120000]
            
            UserInfo.branch = BranchList.Indonesia.rawValue
            break
            
        case CountryList.SriLankan.rawValue:
            languageButton.setTitle("🇱🇰", for: .normal)
            Localize.setCurrentLanguage(LocalizeLanguage.SriLanka.rawValue)
//            cashAmmountList = [7500, 10000, 15000, 20000, 25000, 30000, 35000, 50000]
            cashAmmountList = [10000, 15000, 20000, 25000, 30000, 45000, 60000, 75000]
            UserInfo.branch = BranchList.SriLankan.rawValue
            break
            
        case CountryList.Nigeria.rawValue:
            languageButton.setTitle("🇳🇬", for: .normal)
            Localize.setCurrentLanguage(LocalizeLanguage.Nigeria.rawValue)
            cashAmmountList = [35000, 50000, 75000, 100000, 125000, 150000, 175000, 200000]

            UserInfo.branch = BranchList.Nigeria.rawValue
            break
            
        case CountryList.Philippines.rawValue:
            languageButton.setTitle("🇵🇭", for: .normal)
            Localize.setCurrentLanguage(LocalizeLanguage.Philippines.rawValue)
            cashAmmountList = [40000, 80000, 100000, 12500, 150000, 175000, 200000, 250000]

            UserInfo.branch = BranchList.Philippines.rawValue
            break
            
        default:
            languageButton.setTitle("🇬🇧", for: .normal)
            Localize.setCurrentLanguage(LocalizeLanguage.English.rawValue)
            
            UserInfo.branch = ""
            break
        }
        
        updateCashAmmount()
        
        setDefaults()
    }
    
}

enum LocalizeLabel: String {
    case Indonesia = "🇮🇩"
    case Nigeria = "🇳🇬"
    case Thailand = "🇹🇭"
    case Cambodian = "🇰🇭"
    case Philippines = "🇵🇭"
    case Myanmar = "🇲🇲"
    case SriLankan = "🇱🇰"
    case Lao = "🇱🇦"
    case Default = "🇬🇧"
}

enum CountryList: String {
    case Indonesia = "Indonesia"
    case Nigeria = "Nigeria"
    case Thailand = "Thailand"
    case Cambodian = "Cambodian"
    case Philippines = "Philippines"
    case Myanmar = "Myanmar"
    case SriLankan = "Sri Lankan"
    case Lao = "Lao"
}

enum BranchList: String {
    case Indonesia = "Indonesia"
    case Nigeria = "Nigeria"
    case Thailand = "Thailand"
    case Cambodian = "Cambodia"
    case Philippines = "Philippine"
    case Myanmar = "Myanmar"
    case SriLankan = "Sri Lankan"
    case Lao = "Lao"
    
//    case Zambia = "Zambia"
//    case Cameroon = "Cameroon"
    
//    case Default = ""
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        currentCountry = textField.text ?? ""
//        scrollView.contentOffset.y = textField.frame.origin.y
    }
    
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

