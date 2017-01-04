//
//  MyStoreController.swift
//  Clarks
//
//  Created by Kyle Smith on 8/5/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class MyStoreController: AppViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let collectionTitles = NSArray(array: ["Locator", "My JR", "Scan", "More"])
    let collectionImages = NSArray(array: [Configuration.getImageFromConfig("location", type: "png"), Configuration.getImageFromConfig("myJR", type: "png"), Configuration.getImageFromConfig("barcode", type: "png"), Configuration.getImageFromConfig("more", type: "png")])
    
    var cellWidth = CGFloat()
    var cellHeight = CGFloat()
    var imageSize = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        cellWidth = (self.view.bounds.width - 80)/3
        cellHeight = self.view.bounds.height/5.85
        imageSize = self.view.bounds.height/8.65
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("WHY")
        print(parent?.navigationController)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let widthDifference = (cellWidth - imageSize)/2
        
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        let cellImage = collectionImages.object(at: (indexPath as NSIndexPath).item)
        let cellImageView = UIImageView(image: cellImage as? UIImage)
        let cellText = UITextView()
        cellText.frame = CGRect(x: 0, y: imageSize, width: cellWidth, height: cellHeight - imageSize)
        cellText.font = UIFont(name: ".SFUIText-Light", size: 16)
        cellText.textAlignment = .center
        cellText.text = self.collectionTitles.object(at: (indexPath as NSIndexPath).item) as! String
        cellImageView.frame = CGRect(x: widthDifference, y: 0, width: imageSize, height: imageSize)
        
        cell.addSubview(cellImageView);
        cell.addSubview(cellText)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: cellWidth, height: cellHeight)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let insets = UIEdgeInsetsMake(20, 20, 20, 20)
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                                 minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {

        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        print((indexPath as NSIndexPath).item)
        switch((indexPath as NSIndexPath).item) {
            case 0:
                //performSegueWithIdentifier("showMap", sender: self)
                let storeController = StoreLocatorController()
                
                navigationController?.pushViewController(storeController, animated: true)
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                let moreController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "moreController") as UIViewController
                
                navigationController?.pushViewController(moreController, animated: true)
                //parent?.navigationController?.pushViewController(moreController, animated: true)
                break;
            default:
                print("how did you even..")
                break;
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
