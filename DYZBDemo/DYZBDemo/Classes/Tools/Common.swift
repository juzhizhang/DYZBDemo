//
//  Common.swift
//  DYZBDemo
//
//  Created by admin on 17/12/17.
//  Copyright © 2017年 tdin360. All rights reserved.
//

import UIKit
import Kingfisher


let kWidth = UIScreen.main.bounds.width
let kHeight = UIScreen.main.bounds.height
let kStatusBar:CGFloat = 20
let kNavHeight:CGFloat = 44
let tabbarHeight:CGFloat = 44 


func loadImage(url:String,imageView:UIImageView){
    
    imageView.kf.setImage(with: URL(string:url))

}
