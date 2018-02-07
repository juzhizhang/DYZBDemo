//
//  NormalCollectionViewCell.swift
//  DYZBDemo
//
//  Created by admin on 18/2/3.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var onlineLabel: UIButton!
    
    
    var model:AnchorModel?{
    
    
        
        didSet{
        
            
            guard let model=model else {
                return
            }
            
            
            self.mImageView.kf.setImage(with: URL(string: model.room_src ?? ""))
            self.nicknameLabel.text = model.nickname
            self.titleLabel.text =  model.room_name
            let online = model.online >= 10000 ? " \(model.online/10000)万在线" : " \(model.online)在线"
            self.onlineLabel.setTitle(online, for: .normal)
            
        
        }
    
    }
}
