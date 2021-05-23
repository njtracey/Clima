//
//  WeatherModel.swift
//  Clima
//
//  Created by Nigel Tracey on 15/05/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString : String {
        return String(format: "% .1f", temperature)
    }
    
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321,520:
            return "cloud.drizzle"
        case 500...501,511,521,531:
            return "cloud.rain"
        case 502...504,522:
            return "cloud.heavyrain"
        case 600...602:
            return "cloud.snow"
        case 611...622:
            return "cloud.sleet"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "sun.min"
        case 802:
            return "cloud.sun"
        case 803...804:
            return "cloud"
        default:
            return "exclamationmark.icloud"
        }
    }
    
}

