//
//  PageContentView.swift
//  DYZBDemo
//
//  Created by admin on 17/12/18.
//  Copyright © 2017年 tdin360. All rights reserved.
//

import UIKit


protocol PageContentViewDeletage:class{
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
   
}

class PageContentView: UIView {

    weak var deletage:PageContentViewDeletage?
    fileprivate var childViewControllers:[UIViewController]!
    fileprivate weak var parentController:UIViewController?
    fileprivate var startOffX:CGFloat=0
    fileprivate var isClick=false
    
      init(frame:CGRect,childViewControllers:[UIViewController],parentController:UIViewController) {
        
        super.init(frame: frame)
        self.childViewControllers=childViewControllers
        self.parentController=parentController
        
        self.setupUI()
        
    }
    fileprivate lazy var mCollectionView:UICollectionView={[weak self] in
        
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = self!.bounds.size
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        layout.scrollDirection = .horizontal
        
        let mCollectionView=UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        mCollectionView.showsHorizontalScrollIndicator=false
        mCollectionView.isPagingEnabled=true
        mCollectionView.bounces=false
        mCollectionView.delegate=self
        mCollectionView.dataSource=self
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return mCollectionView
        
        
    }()
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

    
}

extension PageContentView{


    func  setupUI( )  {
 
        
        //1.将子控件添加到父控件中
        for vc in childViewControllers{
    
           self.parentController?.addChildViewController(vc)
        
        }
        //2.添加uicollectionview
        
        self.addSubview(mCollectionView)
        self.mCollectionView.frame=self.bounds
        
        
    }

}

extension PageContentView:UICollectionViewDataSource,UICollectionViewDelegate{


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
   

        for view in cell.contentView.subviews{
        
        
            view.removeFromSuperview()
        }
        
        let childVc = self.childViewControllers[indexPath.row]
    
        childVc.view.frame=cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isClick=false
        startOffX = scrollView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isClick {return}
        
        
        //1.定义数据

        var progress:CGFloat=0
        var sourceIndex:Int=0
        var targetIndex:Int=0
        
        //判断是左滑还是右滑
        
        let currentOffX = scrollView.contentOffset.x
        let scrollViewW=scrollView.bounds.width
        if currentOffX > startOffX{//左滑
        
            //计算progress
        
            progress = currentOffX / scrollView.bounds.width - floor(currentOffX / scrollViewW)
            
            //计算sourceIndex
            sourceIndex = Int(currentOffX/scrollViewW)
            
             targetIndex=sourceIndex+1
            
            if targetIndex>=childViewControllers.count{
            
                targetIndex=childViewControllers.count-1
            
            }
            
            //完全划过去
            if currentOffX - startOffX == scrollViewW {
            
              progress=1
              targetIndex=sourceIndex
            
            }
        
        }else{//右滑
        
            //计算progress
            
            progress = 1-(currentOffX / scrollView.bounds.width - floor(currentOffX / scrollViewW))
             //计算targetIndex
            targetIndex = Int(currentOffX/scrollViewW)
              //计算sourceIndex
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childViewControllers.count{
            
              sourceIndex = childViewControllers.count-1
            
            }
            
        }
        
        
        if deletage != nil {
        
            
            self.deletage?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        }
        
     
        
        
    }
    

}

//对外暴露的方法
extension PageContentView{
    
    func setcurrentIndex(currentIndex:Int){
        
        self.isClick=true
        let offX = CGFloat(currentIndex)*self.mCollectionView.frame.width
        self.mCollectionView.setContentOffset(CGPoint(x: offX, y: 0), animated: true)
        
    }
    

}
