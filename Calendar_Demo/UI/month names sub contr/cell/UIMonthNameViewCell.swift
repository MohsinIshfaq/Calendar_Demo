//
//  UIMonthNameViewCell.swift
//  Microbiz
//
//  Created by Zhao on 06/12/2018.
//  Copyright © 2018 ChinaSoft. All rights reserved.
//

import UIKit

class UIMonthNameViewCell: UITableViewCell {

    //MARK: -IBOUTLET -
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnMonth: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
