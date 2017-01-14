//
//  SpecialSelectedViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 10/31/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpecialSelectedViewController: AppViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var couponTitle: UILabel!
    @IBOutlet var details: UILabel!
    @IBOutlet var expiration: UILabel!
    
    var expires:String!
    var detail:String!
    var titl:String!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        let date = Configuration.dateConvert(date: expires)
        imageView.image = image
        couponTitle.text = titl
        details.text = detail
        expiration.text = date
    }
    
    
}
