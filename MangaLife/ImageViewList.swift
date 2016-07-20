//
//  ImageViewList.swift
//  PanGestureTest
//
//  Created by suncihai on 16/2/8.
//  Copyright © 2016年 suncihai. All rights reserved.
//

import UIKit

class ImageViewList:UIImageView{
    var lastLocation:CGPoint = CGPointMake(0, 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action: Selector("detectPan:"))
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("detectLongPress:"))
        let pinRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("detectPin:"))
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: Selector("detectRotate:"))
        
        longPressRecognizer.minimumPressDuration = 1.0
        self.addGestureRecognizer(panRecognizer)
        self.addGestureRecognizer(longPressRecognizer)
        self.addGestureRecognizer(pinRecognizer)
        self.addGestureRecognizer(rotateRecognizer)

        self.userInteractionEnabled=true

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
    }
    
    func detectLongPress(recognizer:UILongPressGestureRecognizer){
        self.removeFromSuperview()
    }
    
    func detectPin(recognizer:UIPinchGestureRecognizer){
        recognizer.view!.transform = CGAffineTransformScale(recognizer.view!.transform, recognizer.scale, recognizer.scale)
        recognizer.scale = 1.0
    }
    
    func detectRotate(recognizer:UIRotationGestureRecognizer){
        recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation)
        recognizer.rotation = 0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
}
