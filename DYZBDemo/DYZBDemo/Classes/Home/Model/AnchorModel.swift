//
//  AnchorModel.swift
//  DYZBDemo
//
//  Created by admin on 18/2/4.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    
   var room_name:String?
   var room_src:String?
   var online:Int=0
   var nickname:String?
   var anchor_city:String?
    
    
   override init() {
        
    }
    
    
    init(dic:[String:Any]) {
        super.init()
        
        setValuesForKeys(dic)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
