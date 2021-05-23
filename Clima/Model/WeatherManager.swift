//
//  WeatherManager.swift
//  Clima
//
//  Created by Nigel Tracey on 14/05/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = K.htmlScheme
        urlComponents.host = K.OpenWeather.Host
        urlComponents.path = K.OpenWeather.Path
        urlComponents.queryItems = [
            URLQueryItem(name: K.OpenWeather.AppID, value: SK.openWeatherMapAPIKey),
            URLQueryItem(name: K.OpenWeather.UnitsQuery, value: K.OpenWeather.Units),
            URLQueryItem(name: K.OpenWeather.CityQuery, value: cityName)
        ]
        if let urlString = urlComponents.string {
            performRequest(with: urlString)
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        var urlComponents = URLComponents()
        urlComponents.scheme = K.htmlScheme
        urlComponents.host = K.OpenWeather.Host
        urlComponents.path = K.OpenWeather.Path
        urlComponents.queryItems = [
            URLQueryItem(name: K.OpenWeather.AppID, value: SK.openWeatherMapAPIKey),
            URLQueryItem(name: K.OpenWeather.UnitsQuery, value: K.OpenWeather.Units),
            URLQueryItem(name: K.OpenWeather.LatQuery, value: String(latitude)),
            URLQueryItem(name: K.OpenWeather.LonQuery, value: String(longitude))
        ]
        if let urlString = urlComponents.string {
            performRequest(with: urlString)
        }
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handler(data:response:error:))
            task.resume()
        }
    }
    
    func handler(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            delegate?.didFailWithError(error: error!)
            return
        }
        
        if let safeData = data {
            if let weather = parseJSON(safeData) {
                delegate?.didUpdateWeather(self, weather: weather)
            }
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
