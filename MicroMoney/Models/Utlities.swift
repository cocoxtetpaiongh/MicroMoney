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
    static let loadingBackGround = 1002
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
            
            let background = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            background.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
            background.center = view.center
            background.layer.cornerRadius = 8
            
            let label = UILabel()
            label.text = "Loading..."
            label.font = UIFont(name: "Ariel", size: 8)
            
            label.textColor = UIColor.white
            label.textAlignment = .center
            
//            background.addSubview(label)
            let loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            
//            let loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            loading.color = UIColor.blue
            loading.activityIndicatorViewStyle = .whiteLarge
            loading.tag = TagConstants.loadingTag
            loading.tintColor = UIColor.blue
            loading.hidesWhenStopped = true
            
            loading.center = background.center
//            loading.center.x = view.center.x
//            loading.center.y = view.center.y
            
            background.addSubview(loading)
            
            background.tag = TagConstants.loadingBackGround
            
            view.addSubview(background)
            loading.startAnimating()
            view.isUserInteractionEnabled = false

        } else {
            
            if let loading = view.viewWithTag(TagConstants.loadingBackGround) {
                
                loading.removeFromSuperview()
            }
            view.isUserInteractionEnabled = true
        }
        
    }
}
