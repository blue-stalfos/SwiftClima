//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "898b9c0c92dca4c396a5b7ffbea2d669" // This is my API key
	

    //TODO: Declare instance variables here
	let locationManager = CLLocationManager()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
    	locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
	func getWeatherData(url: String, parameters: [String: String]) {
		Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
			response in
			if response.result.isSuccess {
				print("Connection successful! Got the weather data.")
				let weatherJSON: JSON = JSON(response.result.value!)
				self.updateWeatherData(json: weatherJSON)
			} else {
				print("Error \(response.result.error)")
				self.cityLabel.text = "Connection failed. :("
			}
		}
	}
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
	func updateWeatherData(json: JSON) {
		let tempResult = json["main"]["temp"]
	}

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location = locations[locations.count - 1]
		if location.horizontalAccuracy > 0 {
			locationManager.stopUpdatingLocation()
			
			print("latitude = \(location.coordinate.latitude), longitude = \(location.coordinate.longitude)")
			
			let latitude = String(location.coordinate.latitude)
			let longitude = String(location.coordinate.longitude)
			
			let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
			
			getWeatherData(url: WEATHER_URL, parameters: params)
		}
	}
    
    
    //Write the didFailWithError method here:
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
		cityLabel.text = "Location Unavailable"
	}
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}

