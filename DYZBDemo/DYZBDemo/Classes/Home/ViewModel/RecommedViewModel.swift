//
//  RecommedViewModel.swift
//  DYZBDemo
//
//  Created by admin on 18/2/4.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit

class RecommedViewModel {

    lazy var anchorGroups:[AnchorGroup]=[AnchorGroup]()
    fileprivate lazy var mGroup:AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup:AnchorGroup = AnchorGroup()
    lazy var BannerData:[BannerModel]=[BannerModel]()
    
    
}

extension RecommedViewModel{

    
    
    func loadData(finished:@escaping ()->Void) {
   
        let params = ["limit":"4","offset":"0","time":NSDate.getTime()]
        
        
        let dGroup = DispatchGroup.init()
        //1.请求热门数据
        
        dGroup.enter()
        
        NetWorkTool.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["client_sys":"ios","time":NSDate.getTime()], finished: {result in
        
        
            
             self.mGroup.tag_name = "热门"
             self.mGroup.small_icon_url = "home_header_hot"
//             print("-----热门-->>>>",result)
            
            guard let dic =  result as? [String:Any] else{
                
                return
            }
            
            guard let data = dic["data"] as? NSArray else{return}
            
            
            for item in data{
                
                let m = AnchorModel(dic:item as! [String : Any])
            
               self.mGroup.anchors.append(m)
                
            }

            
            dGroup.leave()
            
        
        })
        
        //2.请求颜值数据
        
        dGroup.enter()
        NetWorkTool.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: params, finished: { result in
        
        
//            print("----颜值--->>>",result)
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.small_icon_url = "home_header_phone"
            
            guard let dic =  result as? [String:Any] else{
                
                return
            }
            
            guard let data = dic["data"] as? NSArray else{return}
            
            
            for item in data{
                
                let m = AnchorModel(dic:item as! [String : Any])
                
                self.prettyGroup.anchors.append(m)
                
                
                
            }

            
            dGroup.leave()
            
        })
        
        //3.请求2-12游戏数据
        
        dGroup.enter()
        NetWorkTool.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/getHotCate",params: params, finished: {
        
        result in
        
//              print("请求结果",result)
            
            
            guard let dic =  result as? NSDictionary else{
            
                return
            }
            
            guard let data = dic["data"] as? NSArray else{return}
            
            
            for item in data{
            
                let m = AnchorGroup(dic: item as! [String:Any])
                
                self.anchorGroups.append(m)
                
            
            
            }
   
            
            dGroup.leave()
            
         
        
        })
        
        
        dGroup.notify(queue:DispatchQueue.main, execute: {
        
        
     
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.mGroup, at: 0)
            
            finished()
        
        })
    }

    
    func loadBannerData(finished:@escaping ()->Void){
        
        
        NetWorkTool.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/slide/6", params: ["version":"2.401"], finished: {result in
        
            print("----->>>",result)
            guard let dic =  result as? [String:Any] else{
                
                return
            }
           guard let data = dic["data"] as? NSArray else{return}
            
            
            for item in data{
                
                let m = BannerModel(dic: item as! [String:Any])
                
                self.BannerData.append(m)
                
             
                print("------",m.pic_url ?? "")
                
            }

         
            
            finished()
        
        })
        
    }
    

}
