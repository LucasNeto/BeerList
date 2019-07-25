//
//  ListBeerPresenter.swift
//  BeerList
//
//  Created by Lucas  N Santana on 24/07/19.
//  Copyright (c) 2019 Lucas  N Santana. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListBeerPresentationLogic {
    func presentListBeers(viewModel: ListBeer.FetchBeer.ViewModel)
    func presentDetailBeer()
}

class ListBeerPresenter: ListBeerPresentationLogic {
    weak var viewController: ListBeerDisplayLogic?
    
    
    func presentListBeers(viewModel: ListBeer.FetchBeer.ViewModel){
        viewController?.displayListBeers(viewModel: viewModel)
    }
    func presentDetailBeer(){
        viewController?.displayDetailBeer()
    }
}
