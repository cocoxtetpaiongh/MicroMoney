//
//  MenuTableVC.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/6/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

protocol MenuDelegate: class {
    
    func didSelectMenu(at indexPath: Int)
}

class MenuTableVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MenuDelegate?
    
    var titles = ["Home",
                  "About Micromoney",
                  "Financial Literacy",
                  "Apply Online for Cash Advance",
                  "Prolongation",
                  "Cash Repayment",
                  "FAQs",
                  "Contat Us",
                  "Carrers",
                  "Token Sale"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self 
    }
    
    func dismissAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuButtonPressed() {
        
        dismissAction()
    }

}

extension MenuTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.label.text = titles[indexPath.row]
        return cell
    }
}

extension MenuTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:
        
        dismiss(animated: false, completion: {
            
            self.delegate?.didSelectMenu(at: indexPath.row)
        })
        
//        delegate?.didSelectMenu(at: indexPath.row)
//        dismissAction()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
