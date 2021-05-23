//
//  Constants.swift
//  Clima
//
//  Created by Nigel Tracey on 23/05/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct K {
    static let htmlScheme = "https"
    
    struct OpenWeather {
        static let Host = "api.openweathermap.org"
        static let Path = "/data/2.5/weather"
        static let AppID = "appid"
        static let UnitsQuery = "units"
        static let CityQuery = "q"
        static let LonQuery = "lon"
        static let LatQuery = "lat"
        static let Units = "metric"
    }
}
