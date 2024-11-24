//
//  UIHeaderOfDayViewCell.swift
//  Calendar_Demo
//
//  Created by Mohsin on 12/11/2024.
//

import UIKit

class UIHeaderOfDayViewCell: UITableViewCell {

    //MARK: - IBOutlet -
    
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var btnArrow: UIButton!
    
    //MARK: - Variables -
    
//    var handler: (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(isExpanded:Bool = false) {
//        self.handler = handler
        imgArrow.image = UIImage(named: isExpanded ? "up_arrow" : "arrow_down")
        
    }
    
    //MARK: - IBAction -
    
    @IBAction func onClickArrow(_ sender: UIButton) {
//        self.handler?()
    }
    
}
