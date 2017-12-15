//
//  MainController.swift
//  DYZBDemo
//
//  Created by admin on 17/12/15.
//  Copyright © 2017年 tdin360. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        addContriller(name: "Home")
        addContriller(name: "Live")
        addContriller(name: "Follow")
        addContriller(name: "Profile")
        
    }
 
    
    private func addContriller(name:String){
    
        let storyboard = UIStoryboard.init(name: name, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        
         self.addChildViewController(vc!)
    }
 
}
