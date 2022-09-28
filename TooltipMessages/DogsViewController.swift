//
//  ViewController.swift
//  TooltipMessages
//
//  Created by Raj_iLS on 28/09/22.
//

import UIKit

class DogsViewController: UIViewController {

    @IBOutlet weak var dogsCollection: UICollectionView!
    
    var dogs = [Dogs]()
    var dogsDatasource = GenericCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let option1 = Dogs(name: "Akita", color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), dogImage: #imageLiteral(resourceName: "Akita"))
        let option2 = Dogs(name: "Eskimo", color: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), dogImage: #imageLiteral(resourceName: "Eskimo"))
        let option3 = Dogs(name: "Boerboel", color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), dogImage: #imageLiteral(resourceName: "Boerboel"))
        let option4 = Dogs(name: "Broholmer", color: #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1), dogImage: #imageLiteral(resourceName: "Broholmer"))
        let option5 = Dogs(name: "Bulldog", color: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), dogImage: #imageLiteral(resourceName: "Bulldog"))
        let option6 = Dogs(name: "Bullmastiff", color: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), dogImage: #imageLiteral(resourceName: "Bullmastiff"))
        let option7 = Dogs(name: "Carolina", color: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), dogImage: #imageLiteral(resourceName: "Carolina"))
        let option8 = Dogs(name: "Czechoslovakian", color: #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1), dogImage: #imageLiteral(resourceName: "Czechoslovakian"))
        
        self.dogs.append(contentsOf: [option1, option2, option3, option4, option5, option6, option7, option8])
        
        self.setupOptionsCell(self.dogs)

    }

    func setupOptionsCell(_ data: [Dogs]) {
        dogsDatasource.array = data
        dogsDatasource.identifier = DogsCollectionViewCell.identifier
        
        dogsCollection.dataSource = dogsDatasource
        dogsCollection.delegate = dogsDatasource
        
        dogsDatasource.configure = {cell, index in
            guard let dogsCell = cell as? DogsCollectionViewCell else { return }
            dogsCell.object = data[index]
            
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.dogLongPressed(_:)))
            longPressRecognizer.numberOfTouchesRequired = 1
            longPressRecognizer.allowableMovement = 10
            longPressRecognizer.minimumPressDuration = 0.5
            dogsCell.tag = index
            dogsCell.addGestureRecognizer(longPressRecognizer)
            
        }
        if dogsDatasource.array.count > 0 {
            let label = UILabel(frame: CGRect.zero)
            label.text = dogsDatasource.array[0] as? String
            label.sizeToFit()
            dogsDatasource.sizeItem = CGSize.init(width: (dogsCollection.frame.width/2)-20, height: (dogsCollection.frame.height/4)-40)
        }
        dogsDatasource.didSelect = { cell, index  in
            guard let _ = cell as? DogsCollectionViewCell else { return }
        }
    }
    
    @objc func dogLongPressed(_ sender: UILongPressGestureRecognizer) {
        let index = sender.view?.tag ?? 0
        let fullName =  "\(self.dogs[index].name)  "
        sender.view?.displayTooltip(fullName)
    }
}

