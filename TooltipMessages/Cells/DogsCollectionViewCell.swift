//
//  DogsCollectionViewCell.swift
//  TooltipMessages
//
//  Created by Raj_iLS on 28/09/22.
//

import UIKit

class DogsCollectionViewCell: UICollectionViewCell, ReusableCell {
    @IBOutlet weak var dogImg: UIImageView!
    
    // MARK:- Data loading in table cell
    var object: Dogs? {
        didSet {
            self.layer.cornerRadius = 10
            self.dogImg.layer.cornerRadius = 60
            self.dogImg.image = object?.dogImage
            self.layer.borderWidth = 1.0
            self.layer.borderColor = object?.color.cgColor
            self.backgroundColor = object?.color.withAlphaComponent(0.5)

        }
    }
}

