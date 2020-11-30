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
    
    let weatherObj = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
        // To load image from URL
        // weatherImageView.myLoadFromURL(urlString: "https://openweathermap.org/img/w/01n.png")
    }

    @IBAction func searchButton(_ sender: UIButton) {
        cityLabel.text = searchTextField.text
        weatherObj.fetchWeather(cityName: searchTextField.text!)
    }
    
}

extension ViewController: UITextFieldDelegate {
    // Program search button in screen keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityLabel.text = searchTextField.text
        return true
    }
    
    // Validate if text field is empty
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }
        
        searchTextField.placeholder = "Write some city"
        return false
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
