//
//  DocumentScanVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class DocumentScanVC: UIViewController {
    
    @IBOutlet weak var bankAccoutnImageView: UIImageView!
    
    @IBOutlet weak var iDImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        addGestures()
        // Do any additional setup after loading the view.
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


    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinishedVC") as! FinishedVC
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}


