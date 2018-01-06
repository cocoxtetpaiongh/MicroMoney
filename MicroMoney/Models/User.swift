
//
//  User.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/24/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import Foundation

class UserData: NSObject {
    
    var name = ""
    var country = ""
    var phoneNumber = ""
    
    

}

typealias GUID = String

class UserInfo: NSObject {
    
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
    

}
