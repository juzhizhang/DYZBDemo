//
//  NetWorkTool.swift
//  DYZBDemo
//  网络请求工具类
//  Created by admin on 18/2/4.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit
import Alamofire

enum Type{
    case get
    case post
}

class NetWorkTool{

    
    class func requestData(type:Type,url:String,params:[String:Any]?=nil,finished:@escaping (_ result:Any)->Void){
        
        
         let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method:method, parameters: params).responseJSON(completionHandler: {response in
        
            guard let json = response.result.value else{
                print("请求出错了:",response.result.error ?? "")
               return
            }
            
            finished(json)
        
        })
        
        
     }
}
