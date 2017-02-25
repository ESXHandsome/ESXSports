//
//  HomeTableViewCell.swift
//  XX运动
//
//  Created by Ying on 2016/12/5.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var subtitle: UILabel!

//    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
