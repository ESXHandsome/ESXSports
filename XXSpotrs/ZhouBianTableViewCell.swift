//
//  ZhouBianTableViewCell.swift
//  XX运动
//
//  Created by Ying on 2016/12/19.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class ZhouBianTableViewCell: UITableViewCell {

    @IBOutlet weak var ZBPriceLable: UILabel!
    @IBOutlet weak var ZBTitileLable: UILabel!
    @IBOutlet weak var ZBImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
