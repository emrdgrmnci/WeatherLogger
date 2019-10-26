//
//  OpenWeatherAPI.swift
//  WeatherLogger
//
//  Created by Ali Emre Değirmenci on 24.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

//http://api.openweathermap.org/data/2.5/weather?lat=\(staticData.latitude)&lon=\(staticData.longitude)
//http://api.openweathermap.org/data/2.5/weather?q=London&APPID=61972804d615a47f23448ce031baecaa

import Foundation
import CoreLocation
import UIKit

class NetworkService {

    var description: String = ""

    static let shared = NetworkService()
    let manager = CLLocationManager()
    var locationValue: CLLocationCoordinate2D?

    public func getData(completion: @escaping(OpenWeather) -> () ) {
        //\(staticData.latitude)38.46 - 27.26
        locationValue = manager.location!.coordinate
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(locationValue!.latitude)&lon=\(locationValue!.longitude)&APPID=61972804d615a47f23448ce031baecaa") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            guard let data = data else {
                print("No data!!!")
                return
            }
            do {
                let decoder = try JSONDecoder().decode(OpenWeather.self, from: data)
                DispatchQueue.main.async {
                    completion(decoder)
                }
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
}

