//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func updateWeather(weather: WeatherModel)
    func handleKnownAPIError(errorMessage: String)
    func handleUnknwonAPIError()
    func handleDeviceError(errorMessage: String)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=\(SecretsValues.get().OpenWeatherApiKey)&units=metric"
    
    
    func fetchWeatherByCityName(cityName: String){
        let url = "\(baseUrl)&q=\(cityName)"
        makeRequest(url: url)
    }
    
    
    func fetchWeatherByLocation(latitude: Double, longitude: Double) {
        let url = "\(baseUrl)&lat=\(latitude)&lon=\(longitude)"
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
            delegate?.handleDeviceError(errorMessage: error!.localizedDescription)
            return
        }
        
        if let secureData = data {
            // Decode API JSON response
            let weatherObj = self.parseJSON(weatherData: secureData)
            
            if weatherObj.succeed {
                if weatherObj.errorMessage == nil {
                    // Whoever is the delegated needs to implement the updateWeather method
                    delegate?.updateWeather(weather: weatherObj)
                } else {
                    delegate?.handleKnownAPIError(errorMessage: weatherObj.errorMessage!)
                }
            } else {
                delegate?.handleUnknwonAPIError()
            }
        }
    }
    
    
    func parseJSON(weatherData: Data) -> WeatherModel{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                
            let name = decodedData.name
            let temperature = decodedData.main.temp
            let description = decodedData.weather[0].description
            let windSpeed = decodedData.wind.speed
            let humidity = decodedData.main.humidity
            let temperatureMax = decodedData.main.temp_max
            let temperatureMin = decodedData.main.temp_min
            let iconURL = "https://openweathermap.org/img/w/\(decodedData.weather[0].icon).png"
            
            return WeatherModel(
                succeed: true,
                errorMessage: nil,
                cityName: name,
                temperature: temperature,
                description: description,
                windSpeed: windSpeed,
                humidity: humidity,
                temperatureMax: temperatureMax,
                temperatureMin: temperatureMin,
                iconURL: iconURL
            )
        } catch {
            do {
                let faileddecodedData = try decoder.decode(failedWeatherData.self, from: weatherData)

                return WeatherModel(
                    succeed: true,
                    errorMessage: faileddecodedData.message,
                    cityName: nil,
                    temperature: nil,
                    description: nil,
                    windSpeed: nil,
                    humidity: nil,
                    temperatureMax: nil,
                    temperatureMin: nil,
                    iconURL: nil
                )
            } catch {
                return WeatherModel(
                    succeed: false,
                    errorMessage: nil,
                    cityName: nil,
                    temperature: nil,
                    description: nil,
                    windSpeed: nil,
                    humidity: nil,
                    temperatureMax: nil,
                    temperatureMin: nil,
                    iconURL: nil
                )
            }

        }
    }
}
