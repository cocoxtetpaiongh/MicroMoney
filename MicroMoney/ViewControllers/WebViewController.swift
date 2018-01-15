//
//  WebViewController.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 12/6/17.
//  Copyright © 2017 Coco Xtet Pai. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.hidesWhenStopped = true
        
        webView.delegate = self

        let localfilePath = Bundle.main.url(forResource: "about_mm", withExtension: "html")
        
//        let myRequest = NSURLRequest(URL: localfilePath!);
//        myWebView.loadRequest(myRequest);
        
        let urlString = "https://money.com.mm/about"
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
//            webView.loadRequest(request)
        }
        
        if let localURL = localfilePath {
            
            let request = URLRequest(url: localURL)
            webView.loadRequest(request)

        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true )
    }
}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
    }
}
