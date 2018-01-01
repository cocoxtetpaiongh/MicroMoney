//
//  APIManager.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/16/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

typealias Parameter = [String: Any]

struct JSONResponse: Codable {
    
//    vat response: String = ""
    var status: String = ""
}

enum NetworkStatus {
    case Success
    case Failure
    case Unauthorized
    case Error
}

class APIManager {
    
    static let share = APIManager()
    
    
    // MARK: Create Lead
    func createLead(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: "\(APIConstants.collection)") else {
            return
        }
        
        let user = UserInfo.user
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        let paramaters: [String: Any] = ["Email": user.Email ?? "",
                                         "CityId": user.CityId ?? "",
                                         "UsrBirthDate": user.UsrMMPersonalID ?? "",
                                         "GenderId": user.GenderId ?? "",
                                         "MobilePhone": user.MobilePhone ?? "",
                                         "Contact": user.Contact ?? "",
                                         "UsrMoneyAmount": user.UsrMoneyAmount ?? "",
                                         "UsrTerm": user.UsrTerm ?? "",
                                         "UsrNationalityId": user.UsrNationalityId ?? "",
                                         "CountryId": user.CountryId ?? "",
                                         "Account": user.Account ?? "",
                                         "UsrAccountName": user.UsrAccountName ?? "",
                                         "UsrSalaryAmount": user.UsrSalaryAmount ?? "",
                                         "UsrMMPersonalID": user.UsrMMPersonalID ?? "",
                                         "UsrPaySystemAccount": user.UsrPaySystemAccount ?? "",
                                         "UsrPaySystemId": user.UsrPaySystemId ?? "",
                                         "UsrOccupation": user.UsrOccupation ?? "",
                                         "RegisterMethodId": user.RegisterMethodId ?? ""]
        
        let json = JSON(paramaters) // as! Parameter
        
//        guard let url = URL(string: "\(APIConstants.collection)\(json)") else {
//            return
//        }
        
//        Alamofire.request(url, method: .post, parameters: paramaters, encoding: URLEncoding.default, headers: headers).response { (response) in
//            
//            print(response.data)
//        }
        
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON { (dataRsponse) in
            
            print(dataRsponse.response)
            print(dataRsponse.result.description)
            
            if let json = dataRsponse.value {
                
                completion(json, .Success)
                
            } else {
                
                completion(JSON.null, .Error)
            }
        }

    }
    
    func applyLoan(with parameter: Parameter? = nil, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: "109.120.138.197/0/ServiceModel/EntityDataService.svc/LeadCollection") else {
            return 
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                      "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj"]
        
//        let AUTH_TOKEN_KEY = ""
//        let AUTH_TOKEN = ""
        
        let paras: [String: Any] = ["UsrMoneyAmount": "0000",
                                    "UsrTerm": "0000",
                                    "MobilePhone": "0000",
                                    "Contact": "0000",
                                    "CountryId": "0000"
                                    ]
        
//        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: [AUTH_TOKEN_KEY : AUTH_TOKEN])
//            .responseJSON { response in
//                print(response.request as Any)  // original URL request
//                print(response.response as Any) // URL response
//                print(response.result.value as Any)   // result of response serialization
//        }
        
        Alamofire.request(url, method: .post, parameters: paras, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON { (dataRsponse) in
            
            print(dataRsponse.response)
            print(dataRsponse.result.description)
            
            if let json = dataRsponse.value {
                
                completion(json, .Success)

            } else {
                
                completion(JSON.null, .Error)
            }
        }
    }
    
    func getPaymentList(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        let filter = "$select=Id,Name"
        
        guard let url = URL(string: "\(APIConstants.payment)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        let parameters: [String: Any] = ["$select": "Id,Name",
                                         "$filter": "UsrBranch/Id eq guid'7ffcfa45-b517-441c-86f0-808eaab4dd11'"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            
            guard let responseData = response.data else {
                
                completion(JSON.null, .Error)
                
                return
            }
            
            do {
                
                let json = try JSON(data: responseData)
                completion(json, .Success)
                
            } catch {
                
                print(error)
                completion(JSON.null, .Error)
            }
            
        }
    }
    
    func getGenderList(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.gender) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            
            guard let responseData = response.data else {
                
                completion(JSON.null, .Error)
                
                return
            }
            
            do {
                
                let json = try JSON(data: responseData)
                completion(json, .Success)
                
            } catch {
                
                print(error)
                completion(JSON.null, .Error)
            }
            
        }
    }

    func getCityList(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.city) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { (response) in
            
            guard let responseData = response.data else {
                
                completion(JSON.null, .Error)
                
                return
            }
            
            do {
                
                let json = try JSON(data: responseData)
                completion(json, .Success)
                
            } catch {
                
                print(error)
                completion(JSON.null, .Error)
            }
            
        }
    }

    
    func getNationality(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
//        guard let url = URL(string: "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/CountryCollection") else {
//            return
//        }
        
        guard let url = URL(string: APIConstants.nationality) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { (response) in

            guard let responseData = response.data else {

                completion(JSON.null, .Error)

                return
            }
            
            do {
                
                let json = try JSON(data: responseData)
                completion(json, .Success)
                
            } catch {
                
                print(error)
                completion(JSON.null, .Error)
            }

            
//            if let data = response.result.value {
//
//
//                do {
//
//                    let json = try JSON(data: data)
//                    completion(json, .Success)
//
//                } catch {
//
//                    print(error)
//                    completion(JSON.null, .Error)
//                }
//
//            }
            
        }
    }
    
    func getCountryID(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/CountryCollection") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { (response) in

            print(response.data?.debugDescription)
            print(response.response?.statusCode)
            print(response.result.value)
            
            guard let responseData = response.data else {
                
                return
            }
            
            do {
                
                if let todoJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    
                    print(todoJSON)
                }
            } catch {
                
                print(error)
            }

            if let data = response.result.value {
                
                
                do {
                    
                    let json = try JSON(data: data)
                    completion(json, .Success)

                } catch {
                    
                    print(error)
                }
                
//                let json = JSON(data: data)
//                completion(json, .Success)
            }

        }
        
//        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON { (response) in
//
//            if let json = response.value {
//
//                completion(json, .Success)
//
//            } else {
//
//                completion(JSON.null, .Error)
//            }
//        }

        
        return
  
//        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON { (dataRsponse) in
//
//            print(dataRsponse.response)
//            print(dataRsponse.result.description)
//
//            if let json = dataRsponse.value {
//
//                completion(json, .Success)
//
//            } else {
//
//                completion(JSON.null, .Error)
//            }
//        }

    }
    
    func register(completion: @escaping (JSON, NetworkStatus) -> ()) {
        
        guard let url = URL(string: "\(APIConstants.register)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        let paramaters: [String: Any] = ["$filter": "Name eq 'iOS app'",
                                         "$select": "Id,Name"]
        
        Alamofire.request(url, method: .get, parameters: paramaters, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON { (dataRsponse) in
            
            print(dataRsponse.response)
            print(dataRsponse.result.description)
            
            if let json = dataRsponse.value {
                
                completion(json, .Success)
                
            } else {
                
                completion(JSON.null, .Error)
            }
        }

    }
}





