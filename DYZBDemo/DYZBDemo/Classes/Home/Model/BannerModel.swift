//
//  BannerModel.swift
//  DYZBDemo
//
//  Created by admin on 18/2/7.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit

class BannerModel: NSObject {


    var title:String?
    var pic_url:String?
    
    
    init(dic:[String:Any]) {
        
        super.init()
        
        self.setValuesForKeys(dic)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
