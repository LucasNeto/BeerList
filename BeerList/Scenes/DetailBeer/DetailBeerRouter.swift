//
//  DetailBeerRouter.swift
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

protocol DetailBeerRoutingLogic {
}

protocol DetailBeerDataPassing {
    var dataStore: DetailBeerDataStore? { get }
}

class DetailBeerRouter: NSObject, DetailBeerRoutingLogic, DetailBeerDataPassing {
    weak var viewController: DetailBeerViewController?
    var dataStore: DetailBeerDataStore?
    
}
