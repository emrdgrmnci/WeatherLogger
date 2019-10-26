//
//  DoubleInt.swift
//  WeatherLogger
//
//  Created by Ali Emre Değirmenci on 24.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

extension Double {
    var celcius: Int {
        return Int(self - 273.15)
    }
}
