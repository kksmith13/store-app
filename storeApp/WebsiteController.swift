//
//  WebsiteController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/23/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class WebsiteController: AppViewController {
    
    let webView: UIWebView = {
        let wv = UIWebView()
        wv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let employmentURL = URL(string: "http://www.clark-oil.com")
        let request = URLRequest(url: employmentURL!)
        wv.loadRequest(request)
        return wv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
    }
}
