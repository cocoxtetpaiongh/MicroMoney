//
//  EmploymentInfoVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class EmploymentInfoVC: UIViewController {
    
    @IBOutlet weak var socialStatusTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyNumberTextField: UITextField!
    @IBOutlet weak var incomTextField: UITextField!
    @IBOutlet weak var coworkerNumberTextField: UITextField!
    @IBOutlet weak var coworkerNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GettingMoneyVC") as! GettingMoneyVC
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }

}
