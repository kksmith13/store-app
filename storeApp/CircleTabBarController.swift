
//
//  CircleTabBarController.swift
//  Clarks
//
//  Created by Kyle Smith on 7/29/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import QuartzCore

class CircleTabBarController: AppViewController {
    
    var buttonSelected = 0
    var isAtTop = false
    
    let storeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreController") as UIViewController
    let foodController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodController") as UIViewController
    let specialsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpecialsController") as UIViewController
    
    let leftButton = UIButton()
    let rightButton = UIButton()
    let middleButton = UIButton()
    
    var foodView = UIViewController()
    var specialsView = UIViewController()
    
    var viewOffScreen = CGRect()
    var viewOnScreen = CGRect()
    var viewOffScreenLeft = CGRect()
    var viewOffScreenRight = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.addChildViewController(storeController)
        self.addChildViewController(specialsController)
        self.addChildViewController(foodController)
        
        viewOffScreen = CGRect(x: 0, y: (self.view.bounds.height), width: self.view.bounds.width, height: self.view.bounds.height - 49)
        viewOnScreen = CGRect(x: 0, y: 49, width: self.view.bounds.width, height: self.view.bounds.height - 49)
        
        viewOffScreenLeft = CGRect(x: -self.view.bounds.width, y: 49, width: self.view.bounds.width, height: self.view.bounds.height - 49)
        viewOffScreenRight = CGRect(x: self.view.bounds.width, y: 49, width: self.view.bounds.width, height: self.view.bounds.height - 49)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildCustomBar() {
        
        let primaryColor = Configuration.hexStringToUIColor(hex: UserDefaults.standard.string(forKey: "primaryColor")!)
        let secondaryColor = Configuration.hexStringToUIColor(hex: UserDefaults.standard.string(forKey: "secondaryColor")!)
        
        leftButton.frame = CGRect(x: 0, y: self.view.bounds.height - 49, width: self.view.bounds.width/2, height: 49)
        leftButton.addTarget(self, action: #selector(self.leftButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        rightButton.frame = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height - 49, width: self.view.bounds.width/2, height: 49)
        rightButton.addTarget(self, action: #selector(self.rightButtonPressed(_:)), for: UIControlEvents.touchUpInside)

        middleButton.frame = CGRect(x: self.view.bounds.width/2 - 50, y: self.view.bounds.height - 75, width: 100, height: 100)
        middleButton.layer.cornerRadius = 50
        middleButton.addTarget(self, action: #selector(self.middleButtonPressed(_:)), for: UIControlEvents.touchUpInside)

        setButtonColor(button: leftButton, color: secondaryColor)
        setButtonColor(button: rightButton, color: secondaryColor)
        setButtonColor(button: middleButton, color: primaryColor)
        
        self.view.addSubview(leftButton)
        self.view.addSubview(rightButton)
        self.view.addSubview(middleButton)
        self.view.layoutIfNeeded()
        
    }
    
    // MARK: - Internal Functions
    func setButtonColor(button: UIButton, color: UIColor) {
        button.backgroundColor = color
    }
    // MARK: - Animations
    
    func animateBar() {
        let leftTopFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width/2, height: 49)
        let rightTopFrame = CGRect(x: self.view.bounds.width/2, y: 0, width: self.view.bounds.width/2, height: 49)
        let middleTopFrame = CGRect(x: self.view.bounds.width/2 - 50, y: -25, width: 100, height: 100)
        
        let leftBottomFrame = CGRect(x: 0, y: self.view.bounds.height - 49, width: self.view.bounds.width/2, height: 49)
        let rightBottomFrame = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height - 49, width: self.view.bounds.width/2, height: 49)
        let middleBottomFrame = CGRect(x: self.view.bounds.width/2 - 50, y: self.view.bounds.height - 75, width: 100, height: 100)

        
        UIView.animate(withDuration: 0.7, delay: 0, options: UIViewAnimationOptions(), animations: {
            if (self.leftButton.frame == leftTopFrame){
                self.leftButton.frame = leftBottomFrame
                self.rightButton.frame = rightBottomFrame
                self.middleButton.frame = middleBottomFrame
            } else {
                self.leftButton.frame = leftTopFrame
                self.rightButton.frame = rightTopFrame
                self.middleButton.frame = middleTopFrame
            }
            }, completion: { finished in
                print("animate happened")
        })
    }
    
    func animateOntoScreen(viewAnimatingOff: UIViewController, viewAnimatingOn: UIViewController, fromDirection: NSString) {
        if(fromDirection == "right") {
            view.addSubview(viewAnimatingOn.view)
            viewAnimatingOn.view.frame = self.viewOffScreenRight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
                viewAnimatingOff.view.frame = self.viewOffScreenLeft
                viewAnimatingOn.view.frame = self.viewOnScreen
                
                }, completion: { finished in
                    viewAnimatingOff.view.removeFromSuperview()
            })
        } else if(fromDirection == "left"){
            view.addSubview(viewAnimatingOn.view)
            viewAnimatingOn.view.frame = self.viewOffScreenLeft
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
                viewAnimatingOff.view.frame = self.viewOffScreenRight
                viewAnimatingOn.view.frame = self.viewOnScreen
                
                }, completion: { finished in
                    viewAnimatingOff.view.removeFromSuperview()
            })
        } else {
            print("You must either use left or right when calling this function");
        }
    }

    func animateViewUp() {
        foodController.view.frame = self.viewOffScreen
        specialsController.view.frame = self.viewOffScreen
        storeController.view.frame = self.viewOffScreen
        
        //self.navigationController?.performSegue(withIdentifier: "goToStore", sender: self)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.foodController.view.frame = self.viewOnScreen
            self.specialsController.view.frame = self.viewOnScreen
            self.storeController.view.frame = self.viewOnScreen
            }, completion: { finished in
                UIApplication.shared.isStatusBarHidden = true
        })
        
    }
    
    func animateViewDown() {
        UIApplication.shared.isStatusBarHidden = false
        UIView.animate(withDuration: 0.7, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.foodController.view.frame = self.viewOffScreen
            self.specialsController.view.frame = self.viewOffScreen
            self.storeController.view.frame = self.viewOffScreen
            }, completion: { finished in
                self.foodController.view.removeFromSuperview()
                self.specialsController.view.removeFromSuperview()
                self.storeController.view.removeFromSuperview()
                
        })
        
    }
    
    // MARK: -
    // MARK: Button Controls
    func middleButtonPressed(_ sender: UIButton) {
        print("middlePressed")
        
        if(isAtTop == true && buttonSelected == 2){
            animateBar()
            animateViewDown()
            isAtTop = false
            buttonSelected = 0
        } else if(isAtTop == true && buttonSelected != 2){
            if(buttonSelected == 3) {
                animateOntoScreen(viewAnimatingOff: specialsController, viewAnimatingOn: storeController, fromDirection: "left")
            } else {
                animateOntoScreen(viewAnimatingOff: foodController, viewAnimatingOn: storeController, fromDirection: "right")
            }
            buttonSelected = 2
            
        } else {
            animateBar()
            self.view.addSubview(storeController.view)
            animateViewUp()
            isAtTop = true
            buttonSelected = 2
        }
    }
    
    func leftButtonPressed(_ sender: UIButton){
        print("leftPressed")
        
        if(isAtTop == true && buttonSelected == 1){
            animateBar()
            animateViewDown()
            isAtTop = false
            buttonSelected = 0
        } else if(isAtTop == true && buttonSelected != 1){
            animateOntoScreen(viewAnimatingOff: storeController, viewAnimatingOn: foodController, fromDirection: "left")
            buttonSelected = 1
        } else {
            animateBar()
            self.view.addSubview(foodController.view)
            animateViewUp()
            isAtTop = true
            buttonSelected = 1
        }
    }
    
    func rightButtonPressed(_ sender: UIButton){
        print("rightPressed")

        if(isAtTop == true && buttonSelected == 3){
            animateBar()
            animateViewDown()
            isAtTop = false
            buttonSelected = 0
        } else if(isAtTop == true && buttonSelected != 3){
            animateOntoScreen(viewAnimatingOff: storeController, viewAnimatingOn: specialsController, fromDirection: "right")
            buttonSelected = 3
        } else {
            animateBar()
            self.view.addSubview(specialsController.view)
            animateViewUp()
            isAtTop = true
            buttonSelected = 3
        }
    }
}
