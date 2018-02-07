//
//  Date+Extension.swift
//  DYZBDemo
//
//  Created by admin on 18/2/4.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit


extension NSDate{


   class func getTime() -> String {
        
        
        let nowTime = NSDate()
        
       return "\(nowTime.timeIntervalSince1970)"
        
    }

}

