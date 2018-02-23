
//
//  User.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/24/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import Foundation
import Localize_Swift

class UserData: NSObject {
    
    var name = ""
    var country = ""
    var phoneNumber = ""
    
    

}

typealias GUID = String

//enum UserDefaultsKeys {
//    case isAlreadyLoan = isAlreadyLoan
//}

struct UserDefaultsKeys {
    static var isAlreadyLoan = "isAlreadyLoan"
}

class UserInfo: NSObject {
    
    static func getBranch() {
        
        switch Localize.currentLanguage() {
        case LocalizeLanguage.English.rawValue:
            break
        default:
            break
        }
    }
    
    static func getLocalizedCurrency(with currentLanguage: String) -> String {
        
        switch currentLanguage {
        case CountryList.Myanmar.rawValue:
            return "MMK"

        case CountryList.Thailand.rawValue:
            return "THB"

        case CountryList.Indonesia.rawValue:
            return "IDR"

        case CountryList.Nigeria.rawValue:
            return "USD"

        case CountryList.Philippines.rawValue:
            return "PHP"

        case CountryList.SriLankan.rawValue:
            return "LKR"

        default:
            return "USD"
        }
    }
    
    static func isUserAlreadyLoan() -> Bool {
        
        if let isAlreadyLoan = UserDefaults.standard.value(forKey: UserDefaultsKeys.isAlreadyLoan) as? Bool {
            
            return isAlreadyLoan
        } else {
            
            return false
        }
    }
    
    static func userDidLoan() {
        
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.isAlreadyLoan)
    }
    
    static var branch = BranchList.Thailand.rawValue
    
    static var user = UserInfo()
    
    var Id: GUID? = nil
    var Email: String? = nil
    var CityId: GUID? = nil
    var UsrBirthDate: String? = nil
    var GenderId: GUID? = nil
    var MobilePhone: String? = nil
    var Contact: String? = nil
    var UsrMoneyAmount: Int? = nil
    var UsrTerm: Int? = nil
    var UsrNationalityId: GUID? = nil

    var CountryId: GUID? = nil
    var Account: String? = nil
    var UsrAccountName: String? = nil
    var UsrSalaryAmount: Int? = nil
    var UsrMMPersonalID: String? = nil
    var UsrPaySystemAccount: String? = nil
    var UsrPaySystemId: GUID? = nil
    var UsrPaySystem: String = ""
    var UsrOccupation: String? = nil
    var RegisterMethodId: GUID? = nil
    
    var repaymentDate: String? = nil
    var CoworkerRelationId: GUID? = nil
    var CompanyRelationId: GUID? = nil
    
    var CoworkerId: GUID? = nil
    var CompanyId: GUID? = nil
    
    var CompanyName: String? = nil
    var CompanyPhone: String? = nil
    var CoworkerName: String? = nil
    var CoworkerPhone: String? = nil
    
    var RepayAmount: String? = nil 
    
//    var email: String? = nil
    
    var UsrGps: String? = nil
    var UsrAppEmail: String? = nil
    var UsrAppGoogle: String? = nil
    var UsrAppFacebookMessenger: String? = nil
    var UsrAppFacebookAuth: String? = nil
    var UsrImei: String? = nil


}
