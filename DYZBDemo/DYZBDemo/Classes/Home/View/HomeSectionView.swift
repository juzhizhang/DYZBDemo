//
//  HomeSectionView.swift
//  DYZBDemo
//
//  Created by admin on 18/2/3.
//  Copyright © 2018年 tdin360. All rights reserved.
//

import UIKit

class HomeSectionView: UICollectionReusableView{
 
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var tab_nameLabel: UILabel!
    
    
    var model:AnchorGroup?{
    
    
        didSet{
        
            guard let model = model else {
                
                return
            }
        
            
           self.tab_nameLabel.text=model.tag_name
            
            if model.small_icon_url != nil && model.small_icon_url!.hasPrefix("http"){
            
                
               self.iconImageView.kf.setImage(with: URL(string:model.small_icon_url ?? ""))
            
            }else{
            self.iconImageView.image = UIImage(named: model.small_icon_url ?? "")
            }
        }
    
    }
}
