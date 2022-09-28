//
//  Dogs.swift
//  TooltipMessages
//
//  Created by Raj_iLS on 28/09/22.
//

import Foundation
import UIKit

class Dogs {
    var name: String
    var color: UIColor
    var dogImage = UIImage()

    init (name: String, color: UIColor, dogImage: UIImage) {
        self.name = name
        self.color = color
        self.dogImage = dogImage
    }
}
