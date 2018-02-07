//
//  BannerCollectionViewCell.swift
//  DYZBDemo
//
//  Created by admin on 18/2/7.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }
    
 
    var model:BannerModel?{
    
        didSet{
        
            guard let model = model else {
                return
            }
            
            loadImage(url: model.pic_url ?? "", imageView: self.mImageView)
            
            
            self.titleLabel.text = model.title
        
        }
    
    
    }

}
