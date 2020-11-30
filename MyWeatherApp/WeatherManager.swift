//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=\(SecretsValues.get().OpenWeatherApiKey)&units=metric"
    
    
    func fetchWeather(cityName: String){
        let url = "\(baseUrl)&q=\(cityName)"
        makeRequest(url: url)
    }
    
    
    func makeRequest(url: String) {
        // Create url
        if let url = URL(string: url) {
            // Create  URLSessio object
            let session = URLSession(configuration: .default)
            
            // Assign task to seesion
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            // Start task
            task.resume()
        }
    }
    
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let secureData = data {
            // Decode API JSON response
            self.parseJSON(weatherData: secureData)
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            print(decodedData.name)
            print(decodedData.cod)
            print(decodedData.main.temp)
            print(decodedData.main.humidity)
            print(decodedData.weather[0].description)
            print(decodedData.coord.lon)
            print(decodedData.coord.lat)
        } catch {
            print(error)
        }
    }
}
