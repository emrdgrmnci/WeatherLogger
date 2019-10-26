//
//  DetailWeatherHistoryViewController.swift
//  WeatherLogger
//
//  Created by Ali Emre Değirmenci on 25.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import CoreData

class DetailWeatherHistoryViewController: UIViewController {
    @IBOutlet weak var temperatureDetailLabel: UILabel!
    @IBOutlet weak var cityDetailLabel: UILabel!
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var explanationDetailLabel: UILabel!

    var chosenWeather = ""
    var chosenWeatherId: UUID?

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherDetails()
    }

    func getWeatherDetails() {

        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OpenWeatherData")
        let idString = chosenWeatherId?.uuidString

        fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(fetchRequest)

            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let city = result.value(forKey: "city") as? String {
                        cityDetailLabel.text = city
                    }
                    if let temperature = result.value(forKey: "temperature") as? String {
                        temperatureDetailLabel.text = temperature
                    }
                    if let date = result.value(forKey: "weatherDate") as? String {
                        dateDetailLabel.text = date
                    }
                    if let explanation = result.value(forKey: "weatherDetail") as? String {
                        explanationDetailLabel.text = explanation
                    }
                }
            }
        } catch {
            print("error!!!")
        }
    }
}
