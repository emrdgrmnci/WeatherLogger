//
//  WeatherHistoryViewController.swift
//  WeatherLogger
//
//  Created by Ali Emre Değirmenci on 24.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import CoreData

class WeatherHistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var idArray = [UUID]()
    var cities = [String]()
    var temperatures = [String]()
    var dates = [String]()
    var selectedWeather = ""
    var selectedWeatherId: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        getWeatherDataToTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getWeatherDataToTableView), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func getWeatherDataToTableView() {
        
        cities.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        temperatures.removeAll(keepingCapacity: false)
        dates.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OpenWeatherData")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    if let city = result.value(forKey: "city") as? String {
                        self.cities.append(city)
                    }
                    
                    if let temperatures = result.value(forKey: "temperature") as? String {
                        self.temperatures.append(temperatures)
                    }
                    
                    
                    if let dates = result.value(forKey: "weatherDate") as? String {
                        self.dates.append(dates)
                    }
                    self.historyTableView.reloadData()
                }
            }
        } catch {
            print("error")
        }
    }
}

extension WeatherHistoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWeather = cities[indexPath.row]
        selectedWeatherId = idArray[indexPath.row]

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailHistoryVC = storyBoard.instantiateViewController(withIdentifier: "DetailWeatherHistoryViewController") as! DetailWeatherHistoryViewController
        detailHistoryVC.chosenWeather = selectedWeather
        detailHistoryVC.chosenWeatherId = selectedWeatherId
        tableView.deselectRow(at: indexPath, animated: true)
        
        //         historyDataVC.timeStr = weatherArray[indexPath.row].timeWeather ?? ""
        //         historyDataVC.temperatureStr = String(weatherArray[indexPath.row].temperatura)
        self.navigationController?.pushViewController(detailHistoryVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OpenWeatherData")

            let idString = idArray[indexPath.row].uuidString

            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)

            fetchRequest.returnsObjectsAsFaults = false

            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {

                    for result in results as! [NSManagedObject] {

                        if let id = result.value(forKey: "id") as? UUID {
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                cities.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.historyTableView.reloadData()
                                do {
                                    try context.save()

                                } catch {
                                    print("error")
                                }
                                break
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
    }
}

extension WeatherHistoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "WeatherHistoryCell", for: indexPath) as! WeatherHistoryTableViewCell
        cell.temperatureCityHistoryLabel.text = cities[indexPath.row]
        cell.temperatureHistoryLabel.text = temperatures[indexPath.row]
        cell.temperatureDateHistoryLabel.text = dates[indexPath.row]
        return cell
    }
}
