//
//  Beer.swift
//  BeerList
//
//  Created by Lucas  N Santana on 26/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//

struct Beer: Codable {
    let id: Int?
    let name, tagline, welcomeDescription: String?
    let imageURL: String?
    let abv: Double?
    let ibu: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case welcomeDescription = "description"
        case imageURL = "image_url"
        case abv, ibu
    }
}
