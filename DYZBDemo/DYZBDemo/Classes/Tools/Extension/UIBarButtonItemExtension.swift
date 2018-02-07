//
//  UIBarButtonItem.swift
//  DYZBDemo
//
//  Created by admin on 17/12/15.
//  Copyright © 2017年 tdin360. All rights reserved.
//

import UIKit


extension  UIBarButtonItem{

//    class func cerateItem(imageName:String,highImageName:String,size:CGSize)->UIBarButtonItem{
//    
//    
//        
//        let btn = UIButton()
//        
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:highImageName), for: .highlighted)
//    
//        btn.frame.size=size
//        
//        return UIBarButtonItem(customView: btn)
//    }
//    
    
    convenience init(imageName:String,highImageName:String="",size:CGSize=CGSize.zero) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        if highImageName != "" {
        btn.setImage(UIImage(named:highImageName ), for: .highlighted)
        }
        if size != CGSize.zero {
        btn.frame.size=size
        }else{
        
        btn.sizeToFit()
        }
        
        self.init(customView:btn)
        
    }


}
