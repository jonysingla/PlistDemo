//
//  CellTableViewCell.swift
//  PlistDemo
//
//  Created by Jony Singla on 04/01/17.
//  Copyright © 2017 Jony Singla. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var labelTiming: UILabel!
    @IBOutlet weak var labelMenuName: UILabel!
//    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
