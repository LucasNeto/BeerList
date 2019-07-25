//
//  BeerCollectionViewCell.swift
//  BeerList
//
//  Created by Lucas  N Santana on 24/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(_ txt: String?, image: String?){
        
        imageView.image = #imageLiteral(resourceName: "beer_mask")
        titleLabel.text = txt
        layoutIfNeeded()
        getImageBackground(image)
    }
    
    private func getImageBackground(_ urlString: String?){
        if let urlString = urlString,
            let url = URL(string: urlString){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        
        
    }

}
