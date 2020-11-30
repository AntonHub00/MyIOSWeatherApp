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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
    }

    @IBAction func searchButton(_ sender: UIButton) {
        cityLabel.text = searchTextField.text
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
