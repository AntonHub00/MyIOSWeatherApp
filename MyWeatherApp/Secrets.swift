//
//  Secrets.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation
import UIKit


struct Secrets: Decodable {
    // This must be equal to the key name in secrets.plist
    let OpenWeatherApiKey: String
}


struct SecretsValues {
    static func get() -> Secrets {
        guard let url = Bundle.main.url(forResource: "secrets", withExtension: "plist") else {
            fatalError("Could not find secrets.plist in your Bundle")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(Secrets.self, from: data)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
