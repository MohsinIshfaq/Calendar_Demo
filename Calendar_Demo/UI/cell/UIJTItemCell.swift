//
//  UIJTItemCell.swift
//  Brunata
//
//  Created by Waseem on 12/10/2021.
//

import UIKit
import JTAppleCalendar

typealias CalenderCell = UIJTItemCell
class UIJTItemCell: JTACDayCell {
    
    //MARK: - IBOutlet -
    
    @IBOutlet var selectedView: UIView!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet weak var ViewForBottomIndicator: UIView!
    @IBOutlet weak var customCollectionView: UICollectionView!
    @IBOutlet var constrainForCollectionWidth: NSLayoutConstraint!
    
    //MARK: - Variables -
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    var arrayColor: [UIColor] = []
    
    func config(arrayColor: [UIColor]) {
        
        let width = arrayColor.count * (UIDevice.isIpad ? 19 : 9)
        let removeLastPadding = arrayColor.count > 1 ? (UIDevice.isIpad ? 3 : 2) : 0
        constrainForCollectionWidth.constant = CGFloat(width - removeLastPadding)
        self.arrayColor = arrayColor
        customCollectionView.reloadData()
//        customCollectionView.isHidden = arrayColor.count == 0
    }
}

extension UIJTItemCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let iPadWidth = indexPath.row == arrayColor.count - 1 ? 16 : 19
        let iPhoneWidth = indexPath.row == arrayColor.count - 1 ? 7 : 9
        let width = UIDevice.isIpad ? iPadWidth : iPhoneWidth
        let height = UIDevice.isIpad ? 16 : 7
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICalendarIndicatorCollectionViewCell = collectionView.cell(for: indexPath)
        cell.viewForIndicator.backgroundColor = arrayColor[indexPath.row]
        cell.viewForIndicator.setRoundedCorners()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

