//
//  WeatherHistoryTableViewCell.swift
//  WeatherLogger
//
//  Created by Ali Emre Değirmenci on 24.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class WeatherHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var temperatureCityHistoryLabel: UILabel!
    @IBOutlet weak var temperatureHistoryLabel: UILabel!
    @IBOutlet weak var temperatureDateHistoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        temperatureCityHistoryLabel.text = "İzmir"
        temperatureHistoryLabel.text = "18"
        temperatureDateHistoryLabel.text = "24.10.2019"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
