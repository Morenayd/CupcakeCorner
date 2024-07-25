//
//  Order.swift
//  CupcakeCorner
//
//  Created by Jesutofunmi Adewole on 24/07/2024.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkle"
        case _customOrderEnabled = "customOrderEnabled"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var customOrderEnabled = false {
        didSet {
            if customOrderEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidDeliveryDetails: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type)/2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) * 0.5
        }
        return cost
    }
    
//    func saveDeliveryDetails() {
//        let defaults = UserDefaults.standard
//        defaults.set(name, forKey: "name")
//        defaults.set(streetAddress, forKey: "streetAddress")
//        defaults.set(city, forKey: "city")
//        defaults.set(zip, forKey: "zip")
//    }
//    
//    func loadDeliveryDetails() {
//        let defaults = UserDefaults.standard
//        name = defaults.string(forKey: "name") ?? ""
//        streetAddress = defaults.string(forKey: "streetAddress") ?? ""
//        city = defaults.string(forKey: "city") ?? ""
//        zip = defaults.string(forKey: "zip") ?? ""
//    }
    
}
