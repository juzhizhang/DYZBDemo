//
//  UIColor+Extension.swift
//  DYZBDemo
//
//  Created by admin on 17/12/18.
//  Copyright © 2017年 tdin360. All rights reserved.
//

import UIKit


extension UIColor{

    
       convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        
       self.init(red: r/255, green:g/255, blue: b/255, alpha: 1)
    }

}
