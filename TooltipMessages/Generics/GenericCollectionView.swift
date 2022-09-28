//
//  GenericCollectionView.swift
//  TooltipMessages
//
//  Created by Raj_iLS on 28/09/22.
//

import Foundation
import UIKit

// MARK:- Generic collectionview

class GenericCollectionView<T: UICollectionViewCell>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var didSelect: (T, Int) -> Void = { _, _  in }
    var configure : ((T, Int) -> Void)?
    var didScroll: () -> Void = { }
    var identifier = String()
    var isScrolled = Bool()
    var array: [Any] = []
    var sizeItem = CGSize()
    var emptyMessage = String()
    var hasDummyObj = false

    func registerCells(forTableView tableView: UITableView) {
        tableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func loadCell(atIndexPath indexPath: IndexPath, forCollectionView collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        configure?(cell as! T, indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if array.count == 0 {
             collectionView.setEmptyMessage(emptyMessage)
         }else if array.count == 1 && hasDummyObj == true {
             collectionView.setEmptyMessage("\n\(emptyMessage)")
         }else {
             collectionView.restore()
         }
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.loadCell(atIndexPath: indexPath, forCollectionView: collectionView)
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        didSelect(cell as! T, indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height && !isScrolled {
            didScroll()
            isScrolled = true
        }
    }
}

// MARK:- Generic setting empty message

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
