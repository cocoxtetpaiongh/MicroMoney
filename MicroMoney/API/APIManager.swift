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
    
    func applyLoan(with parameter: Parameter, completion: (JSON, NetworkStatus) -> Void) {
        
        guard let url = URL(string: "") else {
            return 
        }
        
        
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseSwiftyJSON { (dataRsponse) in
            
            print(dataRsponse.response)
            print(dataRsponse.result.description)
        }
    }
}
