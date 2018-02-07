//
//  RecommedViewController.swift
//  DYZBDemo
//  推荐
//  Created by admin on 18/2/3.
//  Copyright © 2018年 tdin360. All rights reserved.
//


private let kNoramlCellID = "kNoramlCellID"
private let kHeaderID = "kHeaderID"
private let kPrettyCellID = "kPrettyCellID"
private let kItemMargin:CGFloat = 10
private let kNormalCellW:CGFloat = (kWidth - 3*kItemMargin)/2
private let kNormalCellH:CGFloat = kNormalCellW * 3/4
private let kPrettyCellH:CGFloat = kNormalCellW * 4/3
private let kHeaderH:CGFloat = 50
private let kBannerViewH:CGFloat = kWidth * 3/8
private let kGameViewH:CGFloat = 90


import UIKit
import Alamofire

class RecommedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

 
        self.setupUI()
        
        self.loadData()
    }
    
    
    fileprivate lazy var recommedViewModel=RecommedViewModel()
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //懒加载轮播图view
    fileprivate lazy var bannerView:BannerView={
        
        
        let bannerView = BannerView.bannerView()
        bannerView.frame  = CGRect(x: 0, y: -kBannerViewH-kGameViewH, width: kWidth, height: kBannerViewH)
        return bannerView
        
    }()
    
    //懒加载游戏推荐菜单
    fileprivate lazy var gameView:RecommedGameView={
    
    
        let gameView = RecommedGameView(frame:CGRect(x:0,y:-kGameViewH,width:kWidth,height:kGameViewH))
         
        return gameView
    
    }()
    //懒加载列表容器
    fileprivate lazy var mCollectionView:UICollectionView={[weak self] in
    
    
        
        let mCollectionView = UICollectionView(frame:self!.view.bounds,collectionViewLayout: UICollectionViewFlowLayout())
        
        //设置背景颜色
         mCollectionView.backgroundColor=UIColor.white
    
        //注册普通cell
        
        let nibCell = UINib.init(nibName: "NormalCollectionViewCell", bundle: nil)
         mCollectionView.register(nibCell, forCellWithReuseIdentifier: kNoramlCellID)
        
        //注册颜值cell
        
        let nibprettyCell = UINib.init(nibName: "PrettyCollectionViewCell", bundle: nil)
         mCollectionView.register(nibprettyCell, forCellWithReuseIdentifier: kPrettyCellID)
        
        //注册分组头view
        
        let nib = UINib.init(nibName: "HomeSectionView", bundle: nil)
        
         mCollectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        //设置item的大小
        
        let layout = mCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:kNormalCellW,height:kNormalCellH)
        layout.headerReferenceSize = CGSize(width:kWidth,height:kHeaderH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        //宽高随父控件缩小而缩小
         mCollectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        
        //设置代理
        
          mCollectionView.delegate=self!
          mCollectionView.dataSource=self!

        return mCollectionView
    
    }()
 
}


extension RecommedViewController{

    
    
    func setupUI()  {
        
        
        //添加collectionview
        self.view.addSubview(mCollectionView)
        
        //添加bannerview
        
        self.mCollectionView.addSubview(self.bannerView)
        
        //添加游戏推荐菜单
        self.mCollectionView.addSubview(self.gameView)
        
        //设置collectionview内边距
        self.mCollectionView.contentInset = UIEdgeInsetsMake(kBannerViewH+kGameViewH, 0, 0, 0)
        
      
        
    }
    
    func loadData( )  {
    
        self.recommedViewModel.loadData{
        
            //更新列表
            
            self.mCollectionView.reloadData()
            
            
            //显示游戏推荐数据
            self.gameView.groups = self.recommedViewModel.anchorGroups
        
        }
        
    
        //请求轮播图数据
        
        self.recommedViewModel.loadBannerData {
            
          self.bannerView.bannerData=self.recommedViewModel.BannerData
        }
        
    }

}

extension RecommedViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{


    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.recommedViewModel.anchorGroups.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         let group = self.recommedViewModel.anchorGroups[section]
        
        return group.anchors.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if indexPath.section == 1{
            
        
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCollectionViewCell
            cell.model = self.recommedViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return cell
        }
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kNoramlCellID, for: indexPath) as! NormalCollectionViewCell
        
        
          cell.model = self.recommedViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! HomeSectionView

        let group = self.recommedViewModel.anchorGroups[indexPath.section]
        headView.model = group
        return headView
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if indexPath.section == 1 {
        
         return CGSize(width:kNormalCellW,height:kPrettyCellH)
            
        }
        return CGSize(width:kNormalCellW,height:kNormalCellH)
       
    }



}
