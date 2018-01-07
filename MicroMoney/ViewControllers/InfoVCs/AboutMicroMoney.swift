//
//  AboutMicroMoney.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/17/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

struct StaticLabel {

    var label: String
    var description: String
    
    init(label: String, description: String) {
        
        self.label = label
        self.description = description
    }
}

typealias AboutSectionsText = [String: String]

class AboutMicroMoney: UIViewController {
    
//    @IBOutlet weak var tableView: UITableView!
    
    var firstSectionLabels = [StaticLabel]()
    var secondSectionLabels = [StaticLabel]()
    var thirdSectionLabels = [StaticLabel]()

    var firstSection = ["Rapid": "This is Micromoney’s motto. We made sure that all it takes is a few minutes for you to complete a hassle free online application. Upon approval, we make sure that you are able get your money in your bank account within 24 hours.",
                        
                        "Simple": "Skip time-consuming queues, complicated application procedures and long approval waiting time. The simple application process, by filling out our online application form to sending a valid proof of your identity, place of residence and income, everything is completed with just a few clicks from your mobile device or computer.",
                        
                        "Transparent": "We make it a priority in being transparent with your loan details. Building trust by making sure that you are clearly informed of your online cash advance terms and conditions."
                        ]
    var secondSection = ["1": "We provide solutions for emergency financial needs. We give Cash Advance which can be acquired through online, not loan. (We are helping people who need money urgently before the salary)",
                         
                         "2": "Our average term is 14 days. Customers can keep the money from minimum 7 days to maximum 21 days.",
                         
                         "3": "We are the company \"Lead Generation Company Limited\" that provides consultancy services for emergency financial needs. This company also serves different services to customers, such as: Consulting service, callcenter support service, credit risk assessment service, technology and web-platform services (company registration no.664FC of 2015-2016(YGN)).",
        
                         "4": "We are working in partnership with pawnshop, licensed under the laws of the government of Myanmar. Pawnshop interest rate is 2.5% per month. License No(4), Botahtaung Township, 2016-2017.",
                         
                         "5": "Customers can get the money just by filling up the online form.",
                         
                         "6": "The fees that customers should pay include both typical interest rate of pawnshop and service fees. Click here to see the tables indicating our daily serice fees.",
                         
                         "7": "Online advance cash services such our service are very popular in USA, whole ASIA, all countries in EUROPE and even in AUSTRALIA."]
    
    var thirdSection = ["Zaplo": "in USA.",
                        "Vivus 1": "in Argentina.",
                        "Vivus 2": "in Maxico.",
                        "Creditocajero": "in Spain.",
                        "Vivus": "in Domanican Republic.",
                        "Pozickomat": "in Slovakia.",
                        "Pozickoma": "in Poland.",
                        "Vivus 3": "in Bulgaria.",
                        "Mycredit": "in Georgia.",
                        "4spar": "in Sweden.",
                        "SMS": "Credit in Lithunia.",
                        "Zaplo 2 ": "in Spain.",
                        "Good Credit": "in Armenia.",
                        "Doctor Cash": "in Philippines.",
                        "Doctor Dong": "in Vietnam.",
                        "Doctor Rupiah": "in Indonesia."]


    var sections = [[String: String]]()
    
    @IBAction func menubuttonPressed(_ seneder: UIButton) {
        
//        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTableVC") as! MenuTableVC
//        menuVC.delegate = self
//        present(menuVC, animated: false, completion: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        registerTableView()
        
        sections.append(firstSection)
        sections.append(secondSection)
        sections.append(thirdSection)
        
        
        
//        for section in firstSection {
//
//            section.key
//        }
    }

//    func registerTableView() {
//
//        var nib = UINib(nibName: "AboutFirstSectionCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "AboutFirstSectionCell")
//
//        nib = UINib(nibName: "AboutSecondSectionCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "AboutSecondSectionCell")
//
//        nib = UINib(nibName: "AboutThirdSectionCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "AboutThirdSectionCell")
//
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 200
//
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
}

extension AboutMicroMoney: UITableViewDelegate {
    
}

extension AboutMicroMoney: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutFirstSectionCell") as! AboutFirstSectionCell
//            let label = Array(section.keys)[indexPath.row]
//            let description = Array(section.values)[indexPath.row]
            
            cell.titleLabel.text = Array(section.keys)[indexPath.row]
            cell.descriptionLabel.text = Array(section.values)[indexPath.row]
            
            return cell
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutSecondSectionCell") as! AboutSecondSectionCell
            
            cell.numberLabel.text = Array(section.keys)[indexPath.row]
            cell.descriptionLabel.text = Array(section.values)[indexPath.row]
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutThirdSectionCell") as! AboutThirdSectionCell
            
            cell.providerLabel.text = Array(section.keys)[indexPath.row]
            cell.regionLabel.text = Array(section.values)[indexPath.row]
            return cell
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutFirstSectionCell") as! AboutFirstSectionCell
//
//        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}
