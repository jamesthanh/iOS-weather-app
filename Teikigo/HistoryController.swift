/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Author: DUONG, Huu Khang
 ID: s3635116
 Created date: 21/09/2018
 Acknowledgment:
 */

// this class contains the logics to handle the history weather part.

import UIKit

protocol HistoryControllerDelegate: class {
    func didFetchHistory (weatherArr newWeatherArr: [Weather])
}

class HistoryController: NSObject {
    // declare variables
    weak var delegate: HistoryControllerDelegate?
    var newWeatherArr: [Weather]?
    var urlStr: String?
    var currentTime: Int?
    let excludeStr = "?exclude=currently,minutely,hourly"
    var count: Int?
    
    // find the previous days
    func fetchDayBefore() {
        if count! > 7 {
            self.delegate?.didFetchHistory(weatherArr: self.newWeatherArr!)
        } else {
            let urlString = urlStr! + ",\(currentTime! - 86400 * count!)" + excludeStr
            print(urlString)
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    let newWeather = try? JSONDecoder().decode(Weather.self, from: data!)
                    self.newWeatherArr?.append(newWeather!)
                    self.count! += 1
                    self.fetchDayBefore()
                })
                task.resume()
            }
        }
    }
    
    // fetch the history from the api link.
    func fetchHistory(currentLat latitude: Double, currentLong longitude: Double) {
        newWeatherArr = [Weather]()
        urlStr = "https://api.darksky.net/forecast/e96b48fdb95327188701d3d865463bca/" + String(latitude) + "," + String(longitude)
        currentTime = Int(Date().timeIntervalSince1970)
        count = 1

        fetchDayBefore()
    }
}
