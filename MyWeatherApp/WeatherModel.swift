//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation


struct WeatherModel {
    let succeed: Bool
    let errorMessage: String?
    let cityName: String?
    let temperature: Double?
    let description: String?
    let iconURL: String?
 }
