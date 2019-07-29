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
    @IBOutlet weak var abvLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(beer: ListBeer.FetchBeer.ViewModel.BeerResumed){
        
        imageView?.image = #imageLiteral(resourceName: "beer_mask")
        titleLabel?.text = beer.name
        abvLabel?.text = beer.abv
        layoutIfNeeded()
        beer.imageUrl?.loadImageWithUrlString(completion: { (image) in
            self.imageView?.image = image
        })
    }

}
