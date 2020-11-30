//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Mac19 on 29/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    var weatherManagerObj = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManagerObj.delegate = self
    }

    
    @IBAction func searchButton(_ sender: UIButton) {
        if searchTextField.text != "" {
            weatherManagerObj.fetchWeather(cityName: searchTextField.text!)
            return
        }
        
        searchTextField.placeholder = "Type some city..."
    }
    
}


extension ViewController: UITextFieldDelegate {
    
    // Program search button in screen keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            weatherManagerObj.fetchWeather(cityName: searchTextField.text!)
            return true
        }
        
        searchTextField.placeholder = "Type some city..."
        return false
    }
}


extension ViewController: WeatherManagerDelegate {
//    func handleKnownAPIError(errorMessage: String) {
//        <#code#>
//    }
//    
//    func handleUnknwonAPIError() {
//        <#code#>
//    }
//    
//    func handleDeviceError(errorMessage: String) {
//        <#code#>
//    }
//    
    
    func updateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = "\(weather.temperature!)°C"
            self.descriptionLabel.text = weather.description
            self.weatherImageView.myLoadFromURL(urlString: weather.iconURL!)
        }
    }
    
}


extension UIImageView {
    
    // Loads image from URL
    func myLoadFromURL(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
