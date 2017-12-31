
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
    
    var Id: Int? = nil
    var Email: String? = nil
    var CityId: GUID? = nil
    var UsrBirthDate: String? = nil
    var GenderId: GUID? = nil
    var MobilePhone: String? = nil
    var Contact: String? = nil
    var UsrMoneyAmount: Double? = nil
    var UsrTerm: Double? = nil
    var UsrNationalityId: GUID? = nil

    var CountryId: GUID? = nil
    var Account: String? = nil
    var UsrAccountName: String? = nil
    var UsrSalaryAmount: Double? = nil
    var UsrMMPersonalID: String? = nil
    var UsrPaySystemAccount: String? = nil
    var UsrPaySystemId: GUID? = nil
    var UsrOccupation: String? = nil
    var RegisterMethodId: GUID? = nil
    
//    var email: String? = nil
    
    

}
