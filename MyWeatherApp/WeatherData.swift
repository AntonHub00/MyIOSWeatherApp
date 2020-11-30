//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation


struct failedWeatherData: Decodable {
    let cod: String
    let message: String
}


struct WeatherData: Decodable {
    let name: String
    let cod: Int
    let main: Main
    let weather: [Weather]
}


struct Main: Decodable {
    let temp: Double
}


struct Weather: Decodable {
    let description: String
    let icon: String
}
