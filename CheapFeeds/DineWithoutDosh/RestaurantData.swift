//
//  RestaurantData.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 30/09/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import Foundation

class RestaurantData{
    
    var id: String
    var averageCostPP: Int
    var currency: String
    var mainImage: String?
    var cuisines: String
    var url: String
    var address: String
    var city: String
    var latitude: String
    var longitude: String
    var menuUrl: String
    var name: String
    //var phoneNumber: String
    var aggregateRating: String?
    
    init(id: String, averageCostPP: Int, currency: String, mainImage: String?, cuisines: String, url: String, address: String, city: String, latitude: String, longitude: String, menuUrl: String, name: String, aggregateRating: String?){
        
        self.id = id
        self.averageCostPP = averageCostPP
        self.currency = currency
        self.mainImage = mainImage
        self.cuisines = cuisines
        self.url = url
        self.address = address
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.menuUrl = menuUrl
        self.name = name
        //self.phoneNumber = phoneNumber
        self.aggregateRating = aggregateRating
    
    }
}
