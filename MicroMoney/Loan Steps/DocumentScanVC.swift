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

        // Do any additional setup after loading the view.
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
//        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinishedVC") as! FinishedVC
//        
//        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }

}
