//
//  HomeViewController.swift
//  SwiftSideslipLikeQQ
//
//  Created by JohnLui on 15/4/10.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit

// 主页
class HomeViewController: UIViewController{

    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    var position:CGPoint!
    
//    let LVC = LeftViewController()
    
//    var RefreshImageViewList:[UIImageView]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="paint pad"
        
//        LVC.delegate = self

        let doubletap = UITapGestureRecognizer(target: self, action: Selector("detectDoubleTap:"))
        doubletap.numberOfTapsRequired=2
        
        self.view.addGestureRecognizer(doubletap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("detectLongPress:"))
        
        self.view.addGestureRecognizer(longPress)
        

        
//        if(RefreshImageViewList.count != 0){
//            for i in 0...RefreshImageViewList.count{
//                self.view.addSubview(RefreshImageViewList[i])
//            }
//        }
    }
    
//    func menuItemSelected(imageview: UIImageView) {
//        self.view.addSubview(imageview)
//    }
    
    func detectLongPress(recognizer:UILongPressGestureRecognizer){
        let optionMenu = UIAlertController(title:nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let SettingsAction = UIAlertAction(title: "Save as picture", style: .Default, handler: {(alert:UIAlertAction)->Void in
            self.screenShotMethod()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(alert:UIAlertAction)->Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(SettingsAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func detectDoubleTap(recognizer:UITapGestureRecognizer){

        let newTextField = TextViewList(frame: CGRect(x: position.x,y: position.y,width: 150,height: 40))
        newTextField.backgroundColor = UIColor.lightGrayColor()
        
        self.view.addSubview(newTextField)
        
    }
    
    func screenShotMethod() {
        //Create the UIImage
        UIGraphicsBeginImageContext(Common.rootViewController.view.frame.size)
        Common.rootViewController.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @IBAction func ClearAll(){
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
        if let touch = touches.first{
            position = touch.locationInView(view)
        }
    }

// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showOtherPages" {
//            if let a = segue.destinationViewController as? OtherPageViewController {
//                a.PageTitle = titleOfOtherPages
//            }
//        }
//    }
    

}
