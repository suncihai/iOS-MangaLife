//
//  TextViewList.swift
//  MangaLife
//
//  Created by suncihai on 16/2/9.
//  Copyright © 2016年 suncihai. All rights reserved.
//

import UIKit

class TextViewList:UITextField{
    var lastLocation:CGPoint = CGPointMake(0, 0)
    
        override init(frame: CGRect) {
        super.init(frame: frame)
        
        let panRecognizer = UIPanGestureRecognizer(target:self, action: Selector("detectPan:"))
 
        self.addGestureRecognizer(panRecognizer)
        
        self.userInteractionEnabled=true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        self.backgroundColor = UIColor.lightTextColor()
        let translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
}
