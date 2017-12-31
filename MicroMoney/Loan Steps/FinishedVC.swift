//
//  FinishedVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class FinishedVC: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var viberHotline1Label: UILabel!
    @IBOutlet weak var viberHotline2Label: UILabel!

    @IBOutlet weak var lineHotline1Label: UILabel!
    @IBOutlet weak var lineHotline2Label: UILabel!

    @IBOutlet weak var mobileHotline1Label: UILabel!
    @IBOutlet weak var mobileHotline2Label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
//        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinishedVC") as! FinishedVC
//
//        navigationController?.pushViewController(nextVC, animated: true)
        
        navigationController?.popToRootViewController(animated: true)

    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
//        navigationController?.popViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }


}
