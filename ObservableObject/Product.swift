//
//  Product.swift
//  ObservableObject
//
//  Created by Christina S on 11/17/19.
//  Copyright © 2019 Schelly. All rights reserved.
//

import Foundation

class Product: ObservableObject {
    @Published var rating = 0
    var name: String
    var currentPrice: Double
    var originalPrice: Double
    var discount: Double
    
    static let `default` = Product(name: "Cool Shoes",
                                   currentPrice: 74.99,
                                   originalPrice: 89.99,
                                   discount: 15.00)
    
    init(name: String,
         currentPrice: Double,
         originalPrice: Double,
         discount: Double) {
        self.name = name
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.discount = discount
        
        
    }
    
    
}


