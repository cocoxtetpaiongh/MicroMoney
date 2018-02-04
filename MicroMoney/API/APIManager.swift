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
    case Updated
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
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
//        var paramaters: [String: Any] = ["Email": user.Email ?? "somebody@mail.com",
//                                         "CityId": user.CityId ?? "e1b8bdae-c8a6-4bd1-b070-0007259a6158",
//                                         "UsrBirthDate": user.UsrBirthDate ?? "1994-01-12",
//                                         "GenderId": user.GenderId ?? "eeac42ee-65b6-df11-831a-001d60e938c6",
//                                         "MobilePhone": user.MobilePhone ?? "09250137382",
//                                         "Contact": user.Contact ?? "Somebody",
//                                         "UsrMoneyAmount": user.UsrMoneyAmount ?? 0,
//                                         "UsrTerm": user.UsrTerm ?? 14,
//                                         "UsrNationalityId": user.UsrNationalityId ?? "4b84d246-8109-4891-a48b-8628ad9cd0cf",
////                                         "CountryId": user.CountryId ?? "",
//                                         "Account": user.Account ?? "Company Name",
//                                         "UsrAccountName": user.UsrAccountName ?? "Account Name",
//                                         "UsrSalaryAmount": user.UsrSalaryAmount ?? 0,
//                                         "UsrMMPersonalID": user.UsrMMPersonalID ?? "12//MaYaKa(N)129933",
//                                         "UsrPaySystemAccount": user.UsrPaySystemAccount ?? "1293393933339999",
//                                         "UsrPaySystemId": user.UsrPaySystemId ?? "e5a2acde-8044-4717-8782-19d498e63070",
//                                         "UsrOccupation": user.UsrOccupation ?? "Stringdsd",
//                                         "RegisterMethodId": user.RegisterMethodId ?? "05813cf2-91e7-4220-ac72-6c94a802bf0f"]
        
        var paramaters: [String: Any] = ["Email": user.Email!,
                                         "CityStr": user.CityId!,
                                         "UsrBirthDate": user.UsrBirthDate!,
                                         "GenderId": user.GenderId!,
                                         "MobilePhone": user.MobilePhone!,
                                         "Contact": user.Contact!,
                                         "UsrMoneyAmount": user.UsrMoneyAmount!.description,
                                         "UsrTerm": user.UsrTerm!.description,
                                         "UsrNationalityId": user.UsrNationalityId!,
//                                         "CountryId": user.CountryId!,
                                         "Account": user.Account!,
                                         "UsrAccountName": user.UsrAccountName!,
                                         "UsrSalaryAmount": user.UsrSalaryAmount!.description,
                                         "UsrMMPersonalID": user.UsrMMPersonalID!,
                                         "UsrPaySystemAccount": user.UsrPaySystemAccount!,
                                         "UsrPaySystemId": user.UsrPaySystemId!,
                                         "UsrOccupation": user.UsrOccupation!,
                                         "UsrGps": user.UsrGps ?? "",
                                         "UsrAppFacebookAuth": user.UsrAppFacebookAuth ?? "",
                                         "RegisterMethodId": user.RegisterMethodId!]
        
//        var UsrGps: String? = nil
//        var UsrAppEmail: String? = nil
//        var UsrAppGoogle: String? = nil
//        var UsrAppFacebookMessenger: String? = nil
//        var UsrAppFacebookAuth: String? = nil
//        var UsrImei: String? = nil
        
        let json = JSON(paramaters) // as! Parameter

        
        let jsonData = json.description.data(using: .utf8, allowLossyConversion: false)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json;odata=verbose", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg=", forHTTPHeaderField: "Accept")
        request.setValue("application/json;odata=verbose", forHTTPHeaderField: "Authorization")

        request.httpBody = jsonData
        
//        Alamofire.request(request).responseSwiftyJSON { (dataRsponse) in
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
        
        
        
        Alamofire.request(url, method: .post, parameters: paramaters, encoding: JSONEncoding.prettyPrinted, headers: APIConstants.headers).responseSwiftyJSON { (dataRsponse) in
            
            print(dataRsponse.response)
            print(dataRsponse.result.description)
            
            if let json = dataRsponse.value {
                
                completion(json, .Success)
                
            } else {
                
                completion(JSON.null, .Error)
            }
        }

    }
    
    // MARK: Company Relation ID
    
    func getCompanyRelationID(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.relation) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        let parameters: [String: Any] = ["$filter": "Name eq 'Workplace'"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: Coworker Relation ID
    
    func getCoworkerRealtionID(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.relation) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        let parameters: [String: Any] = ["$filter": "Name eq 'Coworker'"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: Company ID
    
    func getCompanyID(with leadID: GUID, relationID: GUID, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.update) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        let parameters: [String: Any] = ["$filter": "UsrLead/Id eq guid'\(leadID)' and UsrRelationshipType/Id eq guid'\(relationID)'"]
        
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: Coworker ID
    
    func getCoworkerID(with leadID: GUID, relationID: GUID, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.update) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        let parameters: [String: Any] = ["$filter": "UsrLead/Id eq guid'\(leadID)' and UsrRelationshipType/Id eq guid'\(relationID)'"]
        
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: Update Company

    func updateCompany(with companyID: GUID, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        let guid = "(guid'\(companyID)')"
        guard let url = URL(string: "\(APIConstants.update)\(guid)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        //        let parameters: [String: Any] = ["$filter": "UsrLead/Id eq guid'\(leadID)' and UsrRelationshipType/Id eq guid'\(relationID)'"]
        
        let user = UserInfo.user
        
        let companyName = user.CompanyName ?? "Company Update"
        let companyPhone = user.CompanyPhone ?? "09876543"

        let parameters = ["UsrContactName": companyName,
                          "UsrLocalFullName": companyName,
                          "UsrPhone": companyPhone]
        
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: APIConstants.headers).responseData { (response) in
            
            print(response, ".PUT")
            
            guard let isUpdated = response.data?.isEmpty else {
                
                completion(JSON.null, .Error)
                
                return
            }
            
            if response.response?.statusCode == 204 && isUpdated {
                
                completion(JSON.null, .Updated)

            } else {
                
                completion(JSON.null, .Error)
            }
            
        }
    }
    
    // MARK: Update Coworker
    
    func UpdateCoworker(with companyID: GUID, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        let guid = "(guid'\(companyID)')"
        guard let url = URL(string: "\(APIConstants.update)\(guid)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        //        let parameters: [String: Any] = ["$filter": "UsrLead/Id eq guid'\(leadID)' and UsrRelationshipType/Id eq guid'\(relationID)'"]
        
        let user = UserInfo.user
        
        let coworkerName = user.CoworkerName ?? "CoworkerName"
        let coworkerPhone = user.CoworkerPhone ?? "09876543"
        
        let parameters = ["UsrContactName": coworkerName,
                          "UsrLocalFullName": coworkerName,
                          "UsrPhone": coworkerPhone]
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: APIConstants.headers).responseData { (response) in
            
            print(response, ".PUT")
            
            guard let isUpdated = response.data?.isEmpty else {
                
                completion(JSON.null, .Error)
                
                return
            }
            
            if response.response?.statusCode == 204 && isUpdated {
                
                completion(JSON.null, .Updated)
                
            } else {
                
                completion(JSON.null, .Error)
            }
            
        }
    }
    
    // MARK: Get ID to update Company
    
    func requestUpdateToCompany(with companyID: GUID, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        let guid = "(guid'\(companyID)')"
        guard let url = URL(string: "\(APIConstants.update)\(guid)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
//        let parameters: [String: Any] = ["$filter": "UsrLead/Id eq guid'\(leadID)' and UsrRelationshipType/Id eq guid'\(relationID)'"]
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: GET ID to update Coworker
    
    func requestUpdateToCoworker(with coworkerID: GUID, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        let guid = "(guid'\(coworkerID)')"
        guard let url = URL(string: "\(APIConstants.update)\(guid)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
                                         "Accept": "application/json;odata=verbose"]
        
        //        let parameters: [String: Any] = ["$filter": "UsrLead/Id eq guid'\(leadID)' and UsrRelationshipType/Id eq guid'\(relationID)'"]
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: Upload Image
    
    func requestUpload(with id: GUID, name: String, imageData: Data, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.upload) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        let paras: [String: Any] = ["LeadId": id,
                                    "Name": name
        ]
        
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.prettyPrinted, headers: APIConstants.headers).responseSwiftyJSON { (dataRsponse) in
            
            print(dataRsponse.response)
            print(dataRsponse.result.description)
            
            if let json = dataRsponse.value {
                
                completion(json, .Success)
                
            } else {
                
                completion(JSON.null, .Error)
            }
        }
    }
    
    func uploadImage(with id: GUID, name: String, imageData: Data, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        let guid = "(guid'\(id)')/Data"

        guard let url = URL(string: "\(APIConstants.upload)\(guid)") else {
            return
        }

        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]

        //        let AUTH_TOKEN_KEY = ""
        //        let AUTH_TOKEN = ""
        
        Alamofire.upload(imageData, to: url, method: .put, headers: APIConstants.headers).responseSwiftyJSON { (dataRsponse) in

            print(dataRsponse.response)
            print(dataRsponse.result.description)

            if let json = dataRsponse.value {

                completion(json, .Success)

            } else {

                completion(JSON.null, .Updated)
            }

        }
        
        /*
        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in paras {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
            
//            if let data = imageData {
                multipartFormData.append(imageData, withName: name, fileName: name, mimeType: "image/png")
                
//            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .put, headers: headers) { (result) in
            
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        return
                    }
                    completion(JSON.null, .Success)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                
                completion(JSON.null, .Error)
            }
        }
        */
    }
    
//    func getPaymentList(completion: @escaping (JSON, NetworkStatus) -> Void) {
//
//        let filter = "$select=Id,Name"
//
//        guard let url = URL(string: "\(APIConstants.payment)") else {
//            return
//        }
//
//        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
//                                         "Authorization": "Basic RWFydGg6WWVNaW5UR0E0OTM3dmFj",
//                                         "Accept": "application/json;odata=verbose"]
//
//        let parameters: [String: Any] = ["$select": "Id,Name",
//                                         "$filter": "UsrBranch/Id eq guid'7ffcfa45-b517-441c-86f0-808eaab4dd11'"]
//
//        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { (response) in
//
//            guard let responseData = response.data else {
//
//                completion(JSON.null, .Error)
//
//                return
//            }
//
//            do {
//
//                let json = try JSON(data: responseData)
//                completion(json, .Success)
//
//            } catch {
//
//                print(error)
//                completion(JSON.null, .Error)
//            }
//
//        }
//    }
    
    func applyLoan(with parameter: Parameter? = nil, completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: "109.120.138.197/0/ServiceModel/EntityDataService.svc/LeadCollection") else {
            return 
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                      "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg"]
        
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
        
        Alamofire.request(url, method: .post, parameters: paras, encoding: URLEncoding.default, headers: APIConstants.headers).responseSwiftyJSON { (dataRsponse) in
            
            print(dataRsponse.response)
            print(dataRsponse.result.description)
            
            if let json = dataRsponse.value {
                
                completion(json, .Success)

            } else {
                
                completion(JSON.null, .Error)
            }
        }
    }
    
    // MARK: Payment ID
    
    func getPaymentList(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        let filter = "$select=Id,Name"
        
        guard let url = URL(string: "\(APIConstants.payment)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        let parameters: [String: Any] = ["$select": "Id,Name,Description",
                                         "$filter": "UsrBranch/Id eq guid'7ffcfa45-b517-441c-86f0-808eaab4dd11'"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: Gender ID
    
    func getGenderList(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.gender) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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
    
    // MARK: City ID

    func getCityList(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: APIConstants.city) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in
            
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

    // MARK: Nationality ID
    
    func getNationality(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
//        guard let url = URL(string: "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/CountryCollection") else {
//            return
//        }
        
        guard let url = URL(string: APIConstants.nationality) else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in

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
    
    // MARK: Country ID
    
    func getCountryID(completion: @escaping (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: "http://109.120.138.197/0/ServiceModel/EntityDataService.svc/CountryCollection") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: APIConstants.headers).responseData { (response) in

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
    
    // MARK: Get Register Method ID
    
    func register(completion: @escaping (JSON, NetworkStatus) -> ()) {
        
        guard let url = URL(string: "\(APIConstants.register)") else {
            return
        }
        
        let headers: [String: String] = ["Content-Type": "application/json;odata=verbose",
                                         "Authorization": "Basic RWFydGg6SGVsbDBJWm1lT0JDem9vbDIwMTg",
                                         "Accept": "application/json;odata=verbose"]
        
        let paramaters: [String: Any] = ["$filter": "Name eq 'iOS app'",
                                         "$select": "Id,Name"]
        
        Alamofire.request(url, method: .get, parameters: paramaters, encoding: URLEncoding.default, headers: APIConstants.headers).responseSwiftyJSON { (dataRsponse) in
            
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





