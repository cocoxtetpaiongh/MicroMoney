//
//  InfoViewController.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/6/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit
import Localize_Swift

struct LoanInfoStep {
    
    var title = ""
    var message = ""
    var label = ""
    var image: UIImage?
}

struct LoanAdvantage {
    var label = ""
    var image: UIImage?
    
}

class InfoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIButton!
    
    let hGap: CGFloat = 5
    
    var loanSteps = [LoanInfoStep]()
    
    var loanAdvances = [LoanAdvantage]()

    override func viewDidLoad() {
        super.viewDidLoad()

//        changeLanguage()
        registerNibs()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getLoans()

    }
    
    func changeLanguage(on view: UIView) {
        
        for view in view.subviews {
            
            if let label = view as? UILabel {
                
                label.changeLanguage(with: Localize.currentLanguage())
                
            }
        }
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        
//        dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func getLoans() {
        
        let titles = ["Apply For Loan", "Get Approval", "Sign a Contract", "Receive money"]
        let messages = ["Complete the 5-minute application form", "Get status of your loan approval within 24 hours", "Check your registered email for the loan contract", "Receive cash via bank domestic remittance or via payment system"]
        let images = [#imageLiteral(resourceName: "document"), #imageLiteral(resourceName: "tick"), #imageLiteral(resourceName: "time"), #imageLiteral(resourceName: "money")]
        
        for loan in images.enumerated() {
            
            var loanInfo = LoanInfoStep()
            loanInfo.title = titles[loan.offset]
            loanInfo.message = messages[loan.offset]
            loanInfo.image = loan.element
            loanInfo.label = (loan.offset + 1).description
            
            loanSteps.append(loanInfo)
        }
        
        getAdvantages()
        
        collectionView.reloadData()
    }
    
    func getAdvantages() {
        
        let descriptions = ["Transparent costs",
                            "Simple procedures",
                            "Money will be sent immediately after approval",
                            "Always there for you – any time, any place",
                            "Flexible disbursement and repayment term",
                            "Making life easier"]
        let images = [#imageLiteral(resourceName: "eye"), #imageLiteral(resourceName: "procedure"), #imageLiteral(resourceName: "rocket"), #imageLiteral(resourceName: "clock"), #imageLiteral(resourceName: "calender"), #imageLiteral(resourceName: "hand_shake")]
        
        for loan in images.enumerated() {
            
            var loanAdvance = LoanAdvantage()
            loanAdvance.image = loan.element
            loanAdvance.label = descriptions[loan.offset]
            
            loanAdvances.append(loanAdvance)
        }

    }

    func registerNibs() {
        
        var nib = UINib(nibName: "LoanStepCell", bundle: nil)
//        collectionView.register(nib, forSupplementaryViewOfKind: "nil", withReuseIdentifier: "LoanStepCell")
        collectionView.register(nib, forCellWithReuseIdentifier: "LoanStepCell")
        
        nib = UINib(nibName: "LoanAdvanceCell", bundle: nil)
//        collectionView.register(nib, forSupplementaryViewOfKind: "nil", withReuseIdentifier: "LoanAdvanceCell")
        collectionView.register(nib, forCellWithReuseIdentifier: "LoanAdvanceCell")

        nib = UINib(nibName: "LoanHeaderView", bundle: nil)

//        collectionView.register(nib, forCellWithReuseIdentifier: "LoanHeaderView")
//        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "LoanHeaderView")
        

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
//        let kind = UICollectionElementKindSectionHeader
        
        let titles = ["4 Easy Steps to get a Cash Loan", "Why choose Micro-money"]
        let colors = [UIColor.colorFromHex(hex: "#1E95D7"), UIColor.colorFromHex(hex: "#F97500")]
        
        if kind == UICollectionElementKindSectionHeader {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoanHeaderView", for: indexPath) as! LoanHeaderView
            
//            view.title.text = titles[indexPath.section].uppercased().localized(using: "Info", in: nil)
            view.title.text = titles[indexPath.section].localized()
            view.title.textColor = colors[indexPath.section]
            
//            if Localize.currentLanguage() == "my" {
//
//                view.title.font = UIFont(name: "Zawgyi", size: 17)
//            } else {
//
//                view.title.font = UIFont(name: "Arial_Bold", size: 17)
//
//            }

            self.changeLanguage(on: view)
            
            return view

        } else {
            
            return UICollectionReusableView()
        }
    }
}

extension InfoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoanAdvanceCell", for: indexPath) as! LoanAdvanceCell
            let loan = loanAdvances[indexPath.row]
            cell.image.image = loan.image
            cell.label.text = loan.label
            
            return cell

        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoanStepCell", for: indexPath) as! LoanStepCell
        
        let loanInfo = loanSteps[indexPath.row]
        
        
        print(cell.numberLayer.frame.size.debugDescription)
        cell.descriptionLabel.text = loanInfo.message
        cell.titleLabel.text = loanInfo.title
        cell.numberLabel.text = loanInfo.label
        cell.image.image = loanInfo.image
        cell.numberLayer.layer.cornerRadius = cell.numberLayer.layer.frame.width / 2
        
        cell.layoutIfNeeded()

//        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 4
        }
        
        return 6
    }

}

extension InfoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let titlePerRow: CGFloat = (indexPath.section == 0) ? 2 : 3
        
        let viewWidth:CGFloat = self.view.frame.size.width
        let availableWidth = viewWidth - (hGap * (titlePerRow - 1))
        let itemWidth = availableWidth / titlePerRow
        
        let itemHeight = (indexPath.section == 0) ? itemWidth * 2/3 : itemWidth
        
        var itemSize =  CGSize(width: itemWidth - 15, height: itemHeight)
        
//        itemSize = CGSize(width: 200, height: 100)
        
        return itemSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edge = (section == 0) ? UIEdgeInsetsMake(10, 10, 10, 10) : UIEdgeInsets.zero
        return edge
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        if section == 0 {
            
            return hGap * 3
        }

        return hGap
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if section == 0 {
            
            return hGap * 3
        }
        
        return hGap
    }
}

extension InfoViewController: UICollectionViewDelegate {
    
    
}
