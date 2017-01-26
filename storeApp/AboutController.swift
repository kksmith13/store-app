//
//  AboutController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/23/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class AboutController: AppViewController, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        sv.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
        sv.contentInset = .zero
        sv.scrollIndicatorInsets = .zero
        sv.contentOffset = CGPoint(x: 0.0, y: 0.0)
        sv.delegate = self
        return sv
    }()
    
    let contentView: UIView = {
        let view = AboutView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Our Story"
        view.addSubview(scrollView)
        automaticallyAdjustsScrollViewInsets = false
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        scrollView.addSubview(contentView)
    }
    
}
