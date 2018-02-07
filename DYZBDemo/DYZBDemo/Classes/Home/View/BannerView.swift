//
//  BannerView.swift
//  DYZBDemo
//
//  Created by admin on 18/2/7.
//  Copyright © 2018年 tdin360. All rights reserved.
//


private let bannerCellID="bannerCellID"
import UIKit

class BannerView: UIView {


    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var mPageControl: UIPageControl!
    fileprivate var timer:Timer?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
        
        self.mCollectionView.dataSource=self
        self.mCollectionView.delegate=self
        let nib = UINib(nibName: "BannerCollectionViewCell", bundle: nil)
      
        self.mCollectionView.register(nib, forCellWithReuseIdentifier: bannerCellID)
        
        self.mCollectionView.isPagingEnabled = true
        self.mCollectionView.showsHorizontalScrollIndicator = false
        
      
        
        
    }
    
    
    var bannerData:[BannerModel]?{
    
    
        didSet{
        
        
          self.mCollectionView.reloadData()
            
          self.mPageControl.numberOfPages = bannerData?.count ?? 0
            
          
            //默认滚动到指定位置
            let indexPath = IndexPath.init(item: (bannerData?.count ?? 0) * 20 , section: 0)
        
            self.mCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //启动定时器
            
            self.clearTimer()
            self.startTimer()
        }
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置轮播图大小
        let layout = self.mCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = self.mCollectionView.bounds.size
        
    }
  //通过xib加载view
class func bannerView()->BannerView{

    
    let bannerView = Bundle.main.loadNibNamed("BannerView", owner: nil, options: nil)?.first as! BannerView
    
    
    return bannerView
    }
}

extension BannerView:UICollectionViewDataSource{


    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.bannerData?.count ?? 0) * 10000
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellID, for: indexPath) as! BannerCollectionViewCell
        
        
        cell.model = self.bannerData![indexPath.item % self.bannerData!.count]
       
        
        return cell
        
    }
    
    
}


//实现轮播图指示器跟随
extension BannerView:UICollectionViewDelegate{



    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = Int((scrollView.contentOffset.x + scrollView.bounds.width * 0.5) / kWidth)
        
        self.mPageControl.currentPage = page % (self.bannerData?.count ?? 1)
    }

}



// MARK: - 实现定时滚动
extension BannerView{


    //启动定时器
   fileprivate func startTimer() {
        
        
       self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.startTask), userInfo: nil, repeats: true)
        
    }
    
    //移除定时器
   fileprivate func clearTimer( ){
    
      self.timer?.invalidate()
    
      self.timer = nil
    
    }
    
    //执行定时器任务
    @objc private func startTask(){
        
     
      var offSet = self.mCollectionView.contentOffset
        
      offSet.x += self.mCollectionView.bounds.size.width
        
     self.mCollectionView.setContentOffset(offSet, animated: true)
    }
    
}
