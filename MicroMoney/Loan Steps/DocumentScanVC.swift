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
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    @IBOutlet weak var accountPhotoDesc: UILabel!
    @IBOutlet weak var idPhotoDesc: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!

    var leadID: GUID? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        setText()
        
        addGestures()
        register()
        // Do any additional setup after loading the view.
    }
    
    func setText() {
        
        titleDescription.localize(with: "Documents scan")
        infoDescription.localize(with: "CONGRATULATIONS! We are ready to send you money! Please take clear photos of your documents. If you not yet have bank account , you can continue this application later!")
        
        accountPhotoDesc.localize(with: "Photo of your bank account number.")
        idPhotoDesc.localize(with: "* Photo of your ID/Passport")
        
        nextButton.localize(with: "Next")
        
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
                
                if data == JSON.null {
                    
                    Utlities.showLoading(on: self.view, is: false)
                    Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
                    
                    return
                }
                
                let results = data["results"]
                
                for value in results.arrayValue {
                    
                    let id = value["Id"].stringValue
                    
                    print(id)
                    
                    UserInfo.user.RegisterMethodId = id
                    
                    self.createUser()
                }
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
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
                
                if data == JSON.null {
                    
                    Utlities.showLoading(on: self.view, is: false)
                    Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
                    
                    return
                }
                
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
    
    func uploadImages(passport id: GUID, and name: String) {
        
        guard let image = iDImageView.image else {
            
            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            
            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        guard let leadID = leadID else {

            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        APIManager.share.uploadImage(with: id, name: name, imageData: imageData) { (response, status) in
            
            print(response)
            
            if response == JSON.null && status == .Updated {
                
                self.requestUpload(with: "bankaccount1.png")

                return
            }

            
            if status == .Success {
                
                self.requestUpload(with: "bankaccount1.png")

                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Uploading Photo", "Cannot Upload your passport Photo", "OK", self)
            }
            
        }
        
        
    }
    
    func uploadImages(with id: GUID, and name: String) {
        
        guard let image = bankAccoutnImageView.image else {

            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            
            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        guard let leadID = leadID else {
            
            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        APIManager.share.uploadImage(with: id, name: name, imageData: imageData) { (response, status) in
            
            print(response)
            
            if response == JSON.null && status == .Updated {
                
                Utlities.showLoading(on: self.view, is: false)
                
                self.gotoFinish()

                return
            }
            
            if status == .Success {
                
//                self.uploadImages(with: id)
                
                Utlities.showLoading(on: self.view, is: false)
                
                self.gotoFinish()
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Uploading Photo", "Cannot Upload your Bank Account Image", "OK", self)
            }
            
        }


    }
    
    func requestUpload(passport name: GUID) {
        
        guard let image = iDImageView.image else {
            
            return
        }
        
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            
            return
        }
        
        guard let leadID = leadID else {
            return
        }
        
        Utlities.showLoading(on: self.view, is: true)

        APIManager.share.requestUpload(with: leadID, name: name, imageData: imageData.base64EncodedData()) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                
                let data = response["d"]
                
                if data == JSON.null {
                    
                    Utlities.showLoading(on: self.view, is: false)
                    Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
                    
                    return
                }
                
                let id  = data["Id"].stringValue
                
                self.uploadImages(passport: id, and: name)
                
            } else {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "Error Loading Data", "Cannot Get Gender Data", "OK", self)
            }
            
        }
    }
    
    func requestUpload(with name: GUID) {
        
        guard let image = bankAccoutnImageView.image else {
            
            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            
            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        guard let leadID = leadID else {
            
            Utlities.showLoading(on: self.view, is: false)

            return
        }
        
        APIManager.share.requestUpload(with: leadID, name: name, imageData: imageData.base64EncodedData()) { (response, status) in
            
            print(response)
            
            if response == JSON.null {
                
                Utlities.showLoading(on: self.view, is: false)
                Utlities.showAlert(with: "No Network Connection", "Check your Internet Connection", "OK", self)
                
                return
            }
            
            if status == .Success {
                
                
                let data = response["d"]
                
                if data == JSON.null {
                    
                    Utlities.showLoading(on: self.view, is: false)
                    Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
                    
                    return
                }
                
                let id  = data["Id"].stringValue
                
                self.uploadImages(with: id, and: name)

                
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
                
                if data == JSON.null {
                    
                    Utlities.showLoading(on: self.view, is: false)
                    Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
                    
                    return
                }
                
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
                
                if data == JSON.null {
                    
                    Utlities.showLoading(on: self.view, is: false)
                    Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
                    
                    return
                }
                
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
                
                if data == JSON.null {
                    
                    Utlities.showLoading(on: self.view, is: false)
                    Utlities.showAlert(with: "Error Loading Data", "Can not update your Data", "OK", self)
                    
                    return
                }
                
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
                Utlities.showAlert(with: "Success", "Your data was updated", "OK", self)
                
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

    func validate() -> Bool {
        
        guard iDImageView.image != nil else {
            Utlities.showAlert(with: "No Image", "Capture your passport image", "Ok", self)
            
            return false
        }
        
        guard bankAccoutnImageView.image != nil else {
            Utlities.showAlert(with: "No Image", "Capture your Bank Account image", "Ok", self)
            
            return false
        }
        
        return true
//        gotoFinish()
//        register()
        

    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        
        
        if validate() {
            
            if let id = leadID {
                
//                requestUpload(with: "image1.png")
                requestUpload(passport: "passport1.png")
            }
        }
        
//        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinishedVC") as! FinishedVC
//
//        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}


