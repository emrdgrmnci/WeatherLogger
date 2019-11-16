//
//  WeatherLoggerTests.swift
//  WeatherLoggerTests
//
//  Created by Ali Emre Değirmenci on 23.10.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import XCTest
import CoreLocation

@testable import WeatherLogger

class WeatherLoggerTests: XCTestCase {
    var sut: URLSession!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    // Asynchronous test: success fast, failure slow
    func testValidCallToWeatherAPIGetsHTTPStatusCode200() {
        // given
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=38.46&lon=27.26&APPID=61972804d615a47f23448ce031baecaa")
//        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(locationValue!.latitude)&lon=\(locationValue!.longitude)&APPID=61972804d615a47f23448ce031baecaa")

        // 1
        let promise = expectation(description: "Status code: 200")

        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }

    func testCallToWeatherAPICompletes() {
        // given
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=38.46&lon=27.26&APPID=61972804d615a47f23448ce031baecaa")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)

        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
