//
//  ViewController.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/2/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        registerCells()
    }
    
    func registerCells() {
        
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
}

extension ViewController: UITableViewDelegate {
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}










