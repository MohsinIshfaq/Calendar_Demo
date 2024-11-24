//
//  ExtensionUITableView.swift
//

import UIKit

extension UITableView {
    
    func register(_ cellsName : String)
    {
        self.register(UINib.init(nibName: cellsName, bundle: nil), forCellReuseIdentifier: cellsName)
    }
    
    func register(_ cellsNames : [String])
    {
        cellsNames.forEach { self.register($0) }
    }
    
    func cell<T>(type: T.Type? = nil, for index: IndexPath? = nil) -> T where T: UITableViewCell {
        if let dict = value(forKey: "_nibMap") as? [String: UINib],dict.keys.contains(String(describing: T.self)) { } else {
            register(String(describing: T.self))
        }
        
        if let index = index {
            return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: index) as! T
        } else {
            return self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
        }
    }
    
    func totalNumberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            DispatchQueue.main.async {
                completion()
            }
        })
    }
    
    func indexPathForView(_ view: UIView) -> IndexPath? {
        return self.indexPathForRow(at: view.convert(CGPoint.zero, to:self))
    }
    
    func reloadDataProperly(_ completion: (() -> Void)? = nil) {
        reloadData {
            if let block = completion {
                self.reloadData{
                    block()
                }
            }
            else {
                self.reloadData()
            }
        }
    }
    
//    override func scrollToTop(animated: Bool = true) {
//        if numberOfRows(inSection: 0) > 0 {
//            scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//    }
    
    func scrollTableToBottom(animated: Bool){
        let sectionPosition = self.numberOfSections - 1
        let rowPosition = self.numberOfRows(inSection: sectionPosition) - 1
        
        if sectionPosition >= 0 && rowPosition >= 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: rowPosition, section: sectionPosition)
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
}
