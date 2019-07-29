//
//  Seed.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 27/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//
@testable import BeerList

struct Seeds {
    struct BeerMock {
        static let buzz = Beer(id: 1,
                               name: "Buzz",
                               tagline: "A Real Bitter Experience.",
                               welcomeDescription: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                               imageURL: "https://images.punkapi.com/v2/keg.png",
                               abv: 4.5,
                               ibu: 60.0)
        static let trashyBlonde = Beer(id: 2,
                                       name: "Trashy Blonde",
                                       tagline: "You Know You Shouldn\'t",
                                       welcomeDescription: "A titillating, neurotic, peroxide punk of a Pale Ale. Combining attitude, style, substance, and a little bit of low self esteem for good measure; what would your mother say? The seductive lure of the sassy passion fruit hop proves too much to resist. All that is even before we get onto the fact that there are no additives, preservatives, pasteurization or strings attached. All wrapped up with the customary BrewDog bite and imaginative twist.",
                                       imageURL: "https://images.punkapi.com/v2/2.png",
                                       abv: 4.1,
                                       ibu: 41.5)
        
        static let list = [buzz,trashyBlonde]
        
        
        static let buzzResumed = ListBeer.FetchBeer.ViewModel.BeerResumed(imageUrl: "https://images.punkapi.com/v2/keg.png",
                                                                          name: "Buzz",
                                                                          abv: "abv: 4.5%")
        
        static let trashyBlondeResumed = ListBeer.FetchBeer.ViewModel.BeerResumed(imageUrl: "https://images.punkapi.com/v2/2.png",
                                                                                  name: "Trashy Blonde",
                                                                                  abv: "abv: 4.1%")
        
        static let listResumed = [buzzResumed,trashyBlondeResumed]
        
        
        static let buzzDetailed = DetailBeer.Show.ViewModel.BeerDetailed(imageUrl: "https://images.punkapi.com/v2/keg.png",
                                                                         name: "Buzz",
                                                                         tagline: "A Real Bitter Experience.",
                                                                         abv: "4.5%",
                                                                         ibu: "60.0/100",
                                                                         description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
        
    }
}
