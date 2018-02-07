//
//  AnchorGroup.swift
//  DYZBDemo
//
//  Created by admin on 18/2/5.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    var tag_name:String=""
    var small_icon_url:String?
    var icon_url:String?
    var anchors = [AnchorModel]()
    var room_list:[[String:Any]]?{
    
    
        didSet{
        
            guard let room_list=room_list  else {
                return
            }
            
            
            for room in room_list{
            
            
                let anchor = AnchorModel(dic:room)
             
                anchors.append(anchor)
             
            }
        
        }
    
    }
    
    override init() {
        
        
    }
    
    init(dic:[String:Any]) {
        
        super.init()
        
        setValuesForKeys(dic)
    }
 
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
