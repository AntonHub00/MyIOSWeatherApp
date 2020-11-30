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
    let cod: Int
    let main: Main
    let weather: [Weather]
}


struct Main: Codable {
    let temp: Double
}


struct Weather: Codable {
    let description: String
    let icon: String
}
