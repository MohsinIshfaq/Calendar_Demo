//
//  UIMonthSubViewController.swift
//  Microbiz
//
//  Created by Zhao on 06/12/2018.
//  Copyright © 2018 ChinaSoft. All rights reserved.
//

import UIKit
protocol monthNumberDelegate {
    func selectedMonth(month: Int)
}
class UIMonthSubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - IBOUTLET -
    
    @IBOutlet weak var customTable: UITableView!
    @IBOutlet weak var lblChoose: UILabel!
    @IBOutlet weak var viewForMonths: UIView!
    @IBOutlet weak var constrainForHeight: NSLayoutConstraint!
    
    //MARK:  - Variable -
    
    var delegate: monthNumberDelegate?
    let arrMonthName: [String] = ["january", "february","march","april","may","june","july","august","september","october","november","december"]
    var indexOfMonth : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainForHeight.constant = 585
        customTable.backgroundColor = UIColor.clear
        customTable.backgroundView = nil
        
        lblChoose.text = "Choose Month"//"choose.month".localized
        // Do any additional setup after loading the view.
    }


    // MARK: - TABLE VIEW
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tmpCell : UIMonthNameViewCell = tableView.cell(for: indexPath)
        tmpCell.btnMonth.tag = indexPath.row
        tmpCell.btnMonth.addTarget(self, action: #selector(onClickMonth), for: .touchUpInside)
        tmpCell.lblMonth.text = arrMonthName[indexPath.row].capitalized
        tmpCell.lblMonth.backgroundColor = indexPath.row == indexOfMonth ? UIColor(hex: 0xf7f9fa) : UIColor.clear
        tmpCell.lblMonth.textColor = indexPath.row == indexOfMonth ? AppMainColor : UIColor(hex: 0x303030)
        return tmpCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }

    //MARK: - addTarget Action -
    
    @IBAction func onClickMonth(_ sender: UIButton){
        view.removeFromSuperview()
        view.tag = 0
        delegate?.selectedMonth(month: sender.tag+1)
    }
    
    @IBAction func onClickBackground(_ sender: UIButton){
        view.removeFromSuperview()
        view.tag = 0
    }
}
