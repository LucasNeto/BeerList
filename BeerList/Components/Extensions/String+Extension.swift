//
//  String+Extension.swift
//  BeerList
//
//  Created by Lucas  N Santana on 26/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//
import Foundation
import UIKit

extension String {
    func loadImageWithUrlString(completion: @escaping ((UIImage?) -> Void)){
        if let url = URL(string: self) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                        return
                    }
                }
            }
        }
    }
}
