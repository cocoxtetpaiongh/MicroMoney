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

    var leadID: GUID? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        addGestures()
        register()
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
                
                let data = response["d"]
                
                UserInfo.user.Id = data["Id"].stringValue
                
                self.leadID = data["Id"].stringValue
                
                self.getCompanyRelationID()
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
    }
    
    // MARK: Upload Image
    
    func uploadImage(with name: GUID) {
        
        guard let image = iDImageView.image else {
            
            return
        }
        
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            
            return
        }
        
        guard let leadID = leadID else {
            return
        }
        
        APIManager.share.uploadImage(with: leadID, name: name, imageData: imageData) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                
                let data = response["d"]
                
                UserInfo.user.CompanyRelationId = data["Id"].stringValue
                
                Utlities.showLoading(on: self.view, is: false)
                
                self.gotoFinish()
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
    }
    
    // MARK: Getting Company ID
    
    func getCompanyRelationID() {
        
        APIManager.share.getCompanyRelationID { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                let data = response["d"]
                
                let results = data["results"]
                
                for value in results.arrayValue {
                    
                    let id = value["Id"].stringValue
                    
                    print(id)
                    
                    UserInfo.user.CoworkerRelationId = id
                    
                    self.getCompanyID(with: id)
                    
                }

            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
    }
    
    func getCompanyID(with relationID: GUID) {
        
        guard let leadID = leadID else {
            return
        }
        
        APIManager.share.getCompanyID(with: leadID, relationID: relationID) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                let data = response["d"]
                
                let results = data["results"]
                
                for value in results.arrayValue {
                    
                    let id = value["Id"].stringValue
                    
                    print(id)
                    
                    UserInfo.user.CompanyId = id
                    
                    self.sendRequestToUpdate(company: id)
                    
                }
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
        
    }
    
    // MARK: Update Company
    
    func Update(company companyID: GUID, and userInfo: UserInfo) {
        
        APIManager.share.updateCompany(with: companyID) { (response, status) in
            
            print(response)
            
            if response == JSON.null && status == .Updated {
                
//                Utlities.showLoading(on: self.view, is: false)
//                Utlities.showAlert(with: "Success", "Company Data was updated", "OK", self)
                
                self.getCoworkerRelationID()

                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                
                let data = response["d"]
                
                let id = data["Id"].stringValue
                
                
                self.getCoworkerRelationID()
                
//                Utlities.showLoading(on: self.view, is: false)
                
                //                self.getCompanyRelationID()
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Update your Data", "OK", self)
            }
            
        }
    }
    
    func sendRequestToUpdate(company companyID: GUID) {
        
        APIManager.share.requestUpdateToCompany(with: companyID) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                let data = response["d"]
                
                let id = data["Id"].stringValue
                
                self.Update(company: id, and: UserInfo.user)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
    }
    
    // MARK: Getting Cowroker ID
    
    func getCoworkerRelationID() {
        
        APIManager.share.getCoworkerRealtionID { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                let data = response["d"]
                
                let results = data["results"]
                
                for value in results.arrayValue {
                    
                    let id = value["Id"].stringValue
                    
                    print(id)
                    
                    UserInfo.user.CoworkerRelationId = id
                    
                    self.getCoworkerID(with: id)
                    
                }
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
    }
    
    func getCoworkerID(with relationID: GUID) {
        
        guard let leadID = leadID else {
            return
        }
        
        APIManager.share.getCoworkerID(with: leadID, relationID: relationID) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                let data = response["d"]
                
                let results = data["results"]
                
                for value in results.arrayValue {
                    
                    let id = value["Id"].stringValue
                    
                    print(id)
                    
                    UserInfo.user.CoworkerId = id
                    self.sendRequestToUpdate(coworker: id)
                }

                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }

    }
    
    // MARK: Update Coworker
    
    func sendRequestToUpdate(coworker coworkerID: GUID) {
        
        APIManager.share.requestUpdateToCoworker(with: coworkerID) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                let data = response["d"]
                
                let id = data["Id"].stringValue
                
                self.Update(coworker: id)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }

        }
    }
    
    func Update(coworker coworkerID: GUID) {
        
        APIManager.share.UpdateCoworker(with: coworkerID) { (response, status) in
            
            print(response)
            
            if response == JSON.null && status == .Updated {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Success", "coworker Data was updated", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                Utlities.showLoading(on: self.view, is: false)
                
                let data = response["d"]
                
                let id = data["Id"].stringValue
                
                
                
                
                Utlities.showLoading(on: self.view, is: false)
                
                //                self.getCompanyRelationID()
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Update your Data", "OK", self)
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
        
        gotoFinish()
//        register()
        

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


