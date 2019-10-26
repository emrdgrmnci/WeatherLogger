//
//  ViewController.swift
//  WeatherLogger
//
//  Created by Ali Emre Değirmenci on 23.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    let locationManager = CLLocationManager()

    static let sharedWeatherForCoordinates = WeatherViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getWeatherButton(_ sender: Any) {
        getCurrentDate()
        getApiData()
    }

    @IBAction func saveToCoreData(_ sender: Any) {
        saveLocalData()
    }
    
    //MARK: - Save localdata(CoreData)
    func saveLocalData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newWeatherData = NSEntityDescription.insertNewObject(forEntityName: "OpenWeatherData", into: context)
        newWeatherData.setValue(UUID(), forKey: "id")
        newWeatherData.setValue(cityLabel.text!, forKey: "city")
        newWeatherData.setValue(dateLabel.text!, forKey: "weatherDate")
        newWeatherData.setValue(weatherStatusLabel.text!, forKey: "weatherDetail")
        newWeatherData.setValue(temperatureLabel.text!, forKey: "temperature")
        do {
            try context.save()
            self.showAlert(withTitle: "Saved", withMessage: "Your weather data saved successfully!")
            print("Success!")
        } catch {
            self.showAlert(withTitle: "Error", withMessage: "Your weather data does not saved successfully!")
            print(error.localizedDescription)
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
    }

    //MARK: - Get apiData
    func getApiData() {
        NetworkService.shared.getData { (response) in
            self.cityLabel.text = response.name
            self.temperatureLabel.text = "\(response.main.temp.celcius)°C"
            self.weatherStatusLabel.text = response.weather[0].description
            print(response.name)
        }
    }

    //MARK: - Get currentDate
    func getCurrentDate() {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let formattedDate = format.string(from: date)
        dateLabel.text = formattedDate
    }
}




