//
//  PrettyCollectionViewCell.swift
//  DYZBDemo
//
//  Created by admin on 18/2/3.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var nickNameLabel: UILabel!

    @IBOutlet weak var addressLabel: UIButton!
    
    
    
    var model:AnchorModel?{
    
    
        didSet{
        
        
            guard let model = model else {
                return
            }
            
            
            self.mImageView.kf.setImage(with: URL(string:model.room_src ?? ""))
            self.addressLabel.setTitle(model.anchor_city ?? "", for: .normal)
            self.nickNameLabel.text = model.nickname
            self.onlineLabel.text = "\(model.online)在线"
        }
    
    }
}
