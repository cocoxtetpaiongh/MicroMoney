//
//  PersonalInfoVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/14/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class PersonalInfoVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var birthMonthTextField: UITextField!
    @IBOutlet weak var birthYearTextField: UITextField!

    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var nationalTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmploymentInfoVC") as! EmploymentInfoVC
        
        navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}
