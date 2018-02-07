//
//  HomeController.swift
//  DYZBDemo
//  首页
//  Created by admin on 17/12/15.
//  Copyright © 2017年 tdin360. All rights reserved.
//

import UIKit

class HomeController: UIViewController{

    
    //懒加载标题view
    fileprivate lazy var pageView:PageTitleView={[weak self] in
    
    
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let pageView = PageTitleView(frame:CGRect(x:0,y:Int(kStatusBar+kNavHeight),width:Int(kWidth),height:40),titles: titles)
        
        pageView.deletage=self!
        return pageView
    
    }()
   
    //懒加载内容view
    fileprivate lazy var pageContentView:PageContentView={[weak self] in
        
        
        let h:CGFloat = kHeight-kNavHeight-kStatusBar-40-tabbarHeight
        let rect = CGRect(x:0,y:kNavHeight+kStatusBar+40,width:kWidth,height:h)
        
        var childs = [UIViewController]()
        
        childs.append(RecommedViewController())
        for idx in 0..<3{
            
            let vc = UIViewController()
            
             vc.view.backgroundColor=UIColor.init(r: CGFloat(arc4random_uniform(255)), g:  CGFloat(arc4random_uniform(255)), b:  CGFloat(arc4random_uniform(255)))
           
            childs.append(vc)
            
        }
        
        let pageContentView=PageContentView(frame:rect,childViewControllers: childs,parentController: self!)
         pageContentView.deletage=self!
        return pageContentView
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        
        
        //设置ui界面
        self.setupUI()
        
        
  
    }
    
    
 
}

extension HomeController{

    
    
  fileprivate func setupUI(){
    
    
    self.automaticallyAdjustsScrollViewInsets=false
    //1.设置导航栏
    
    self.setNavBar()
    
    //添加titleview
    
    self.view.addSubview(pageView)
    
    //添加内容view
    
    self.view.addSubview(pageContentView)
       pageContentView.backgroundColor=UIColor.red
        
    
    }
    
    private func setNavBar(){
    
     
        //设置左侧item
       
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(imageName: "logo")
        
        
    
        //设置右侧item
         let size = CGSize(width:40,height:40)
    
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
    
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        

        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
        self.navigationItem.rightBarButtonItems=[historyItem,searchItem,qrcodeItem]

        
    }

}

extension HomeController:PageTitleViewDeletage,PageContentViewDeletage{


    func pageTitleview(titleView: PageTitleView, SelectIndex index: Int) {
        
        
        self.pageContentView.setcurrentIndex(currentIndex: index)
        
    }

    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageView.setTitleProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

}

