//
//  DocumentScanVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import SwiftyJSON

class DocumentScanVC: UIViewController {
    
    @IBOutlet weak var bankAccoutnImageView: UIImageView!
    
    @IBOutlet weak var iDImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        addGestures()
//        register()
        // Do any additional setup after loading the view.
    }
    
    func register() {
        
        Utlities.showLoading(on: self.view, is: true)
        
        APIManager.share.register { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                
                let data = response["d"]
                let results = data["results"]
                
                for value in results.arrayValue {
                    
                    let id = value["Id"].stringValue
                    
                    print(id)
                    
                    UserInfo.user.RegisterMethodId = id
                    
                    self.createUser()
                }
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }

        }
    }
    
    func createUser() {
        
        APIManager.share.createLead { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                
                let data = response["d"]
                let results = data["results"]
                
                for value in results.arrayValue {
                    
                    let id = value["Id"].stringValue
                    
                    print(id)
                    
                    UserInfo.user.RegisterMethodId = id
                }
                
                Utlities.showLoading(on: self.view, is: false)

                self.gotoFinish()
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
    }
    
    func addGestures() {
        
        let passportGesture = UITapGestureRecognizer(target: self, action: #selector(self.handPassport(_:)))
        
        iDImageView.addGestureRecognizer(passportGesture)
        
        let bankGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleBankAccount(_:)))
        
        bankAccoutnImageView.addGestureRecognizer(bankGesture)
        
        iDImageView.isUserInteractionEnabled = true
        bankAccoutnImageView.isUserInteractionEnabled = true

    }
    
    @objc func handleBankAccount(_ recognizer: UITapGestureRecognizer) {
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
         
            self.bankAccoutnImageView.image = image
        }
    }
    
    @objc func handPassport(_ recognizer: UITapGestureRecognizer) {
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            
            self.iDImageView.image = image
        }
    }
    
    func gotoFinish() {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinishedVC") as! FinishedVC
        
        navigationController?.pushViewController(nextVC, animated: true)

    }

    func validate() {
        
        guard iDImageView.image != nil else {
            Utlities.showAlert(with: "No Image", "Capture your passport image", "Ok", self)
            
            return
        }
        
        guard bankAccoutnImageView.image != nil else {
            Utlities.showAlert(with: "No Image", "Capture your Bank Account image", "Ok", self)
            
            return
        }
        
        register()

    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        
        
        validate()
        
//        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinishedVC") as! FinishedVC
//
//        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}


