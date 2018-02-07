//
//  RecommedGameView.swift
//  DYZBDemo
//
//  Created by admin on 18/2/7.
//  Copyright © 2018年 tdin360. All rights reserved.
//


private let kGameViewCellID = "kGameViewCellID"
import UIKit

class RecommedGameView: UIView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         self.addSubview(mCollectionView)

     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //懒加载菜单itemView
    fileprivate lazy var mCollectionView:UICollectionView={
    
        
        let mCollectionView = UICollectionView(frame:self.bounds,collectionViewLayout: UICollectionViewFlowLayout())
         mCollectionView.dataSource = self
         mCollectionView.showsHorizontalScrollIndicator = false
         mCollectionView.backgroundColor = UIColor.white
         let nib = UINib(nibName: "GameViewCollectionViewCell", bundle: nil)
         mCollectionView.register(nib, forCellWithReuseIdentifier: kGameViewCellID)
         let layout = mCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:80,height:self.bounds.size.height)
        
        return mCollectionView
     
    
    }()
    
    
    
    var groups:[AnchorGroup]?{
    
        
        didSet{
        
            //移除颜值和热门
            self.groups?.removeFirst()
            self.groups?.removeFirst()
        
            self.mCollectionView.reloadData()
        
        }
    
    }
    
    
}

extension RecommedGameView:UICollectionViewDataSource{

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! GameViewCollectionViewCell
        
          cell.model = groups![indexPath.item]
        
        
        return cell
        
    }

}
