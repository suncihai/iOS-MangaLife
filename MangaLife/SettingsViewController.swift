//
//  SettingsViewController.swift
//  MangaLife
//
//  Created by suncihai on 16/2/10.
//  Copyright © 2016年 suncihai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func BackToHomeViewController(){
        self.performSegueWithIdentifier("BackToHome", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}
