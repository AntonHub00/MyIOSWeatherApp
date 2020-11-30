//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let cod: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let description: String
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}
