//
//  Utlities.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/24/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

struct TagConstants {
    static let loadingTag = 1001
}

class Utlities: NSObject {

    static func showAlert(with title: String, _ message: String, _ action: String,_ controller: UIViewController, completion: (() -> ())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: action, style: .default) { (action) in
            
            if let completion = completion {
                
                completion()
            }
        }
        
        alert.addAction(action)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showLoading(on view: UIView, `is` show: Bool) {
        
        if show {
            
            let loading = UIActivityIndicatorView()
            loading.color = UIColor.gray
            loading.activityIndicatorViewStyle = .gray
            loading.tag = TagConstants.loadingTag
            
            loading.hidesWhenStopped = true
            
            view.addSubview(loading)
            loading.startAnimating()
            view.isUserInteractionEnabled = false

        } else {
            
            if let loading = view.viewWithTag(TagConstants.loadingTag) {
                
                loading.removeFromSuperview()
            }
            view.isUserInteractionEnabled = true
        }
        
    }
}
