//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation


struct failedWeatherData: Codable {
    let cod: String
    let message: String
}


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}


struct Main: Codable {
    let temp: Double
    let humidity: Int
    let temp_max: Double
    let temp_min: Double
}


struct Weather: Codable {
    let description: String
    let icon: String
}


struct Wind: Codable{
    let speed: Double
}
