//
//  APIConstants.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/16/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import Foundation

struct APIConstants {
    
    static let baseURL = "109.120.138.197/0/ServiceModel/EntityDataService.svc/LeadCollection"
    
    static let nationality = "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/UsrNationalityCollection"
    
    static let gender = "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/GenderCollection"
    
    static let payment = "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/UsrPaySystemCollection"
    
    static let register = "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/LeadRegisterMethodCollection" //?$filter=Name eq 'iOS app'&$select=Id,Name"
    
    static let collection = "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/LeadCollection"
}
