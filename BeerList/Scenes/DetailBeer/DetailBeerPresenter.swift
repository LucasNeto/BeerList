//
//  DetailBeerPresenter.swift
//  BeerList
//
//  Created by Lucas  N Santana on 25/07/19.
//  Copyright (c) 2019 Lucas  N Santana. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailBeerPresentationLogic {
    func presentBeer(response: DetailBeer.Show.Response)
}

class DetailBeerPresenter: DetailBeerPresentationLogic {
    weak var viewController: DetailBeerDisplayLogic?
    
    // MARK: DetailBeerPresentationLogic
    
    func presentBeer(response: DetailBeer.Show.Response) {
        let beer = response.beer
        let name = beer?.name ?? "Nome não encontrado"
        let tagline = beer?.tagline ?? "Cerveja sem slogan."
        let abv = beer?.abv != nil ? "\(String(describing: beer!.abv!))%" : "abv não encontrado"
        let ibu = beer?.ibu != nil ? "\(String(describing: beer!.ibu!))/100" : "ibu não encontrado"
        let desc = beer?.welcomeDescription ?? "Cerveja sem descrição"
        
        
        let beerDetailed = DetailBeer.Show.ViewModel.BeerDetailed(imageUrl: beer?.imageURL,
                                                                  name: name,
                                                                  tagline: tagline,
                                                                  abv: abv,
                                                                  ibu: ibu,
                                                                  description: desc)
        let viewModel = DetailBeer.Show.ViewModel(beerDetailed: beerDetailed)
        viewController?.displayBeer(viewModel: viewModel)
    }
}