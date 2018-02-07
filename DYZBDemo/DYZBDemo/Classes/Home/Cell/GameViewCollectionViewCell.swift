//
//  GameViewCollectionViewCell.swift
//  DYZBDemo
//
//  Created by admin on 18/2/7.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit

class GameViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var model:AnchorGroup?{
    
    
        didSet{
        
        
            guard let model = model else {
                return
            }
            
            loadImage(url: model.icon_url ?? "", imageView: self.mImageView)
            
            self.titleLabel.text = model.tag_name
            
        
        }
    
    }

}
