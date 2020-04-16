/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Authors:
 HOANG, Quang Huy (s3623383)
 DUONG, Huu Khang (s3635116)
 NGUYEN, Tan Thanh (s3634815)
 Created date: 21/09/2018
 Acknowledgment: 
 */






import Foundation


class GraphController {
    
    func getHourContent (identifier: Int) -> [Float] {
        var values = [Float]()
        
        switch identifier {
        case 0:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].humidity!)
            }
            return values
        case 1:
            for i in 0...23 {
                values.append(Float(CurrentViewController.weather!.hourly!.data![i].uvIndex!))
            }
            return values
        case 2:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].visibility!)
            }
            return values
        case 3:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].windSpeed!)
            }
            return values
        case 4:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].pressure!)
            }
            return values
        case 5:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].ozone!)
            }
            return values
        case 6:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].precipProbability!)
            }
            return values
        case 7:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].precipIntensity!)
            }
            return values
        case 8:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].temperature!)
            }
            return values
        default:
            for i in 0...23 {
                values.append(CurrentViewController.weather!.hourly!.data![i].temperature!)
            }
            return values
        }
    }
    
    func getHourTag(identifier: Int) -> String {
        switch identifier {
        case 0:
            return "Humidity"
        case 1:
            return "UV"
        case 2:
            return "Visibility"
        case 3:
            return "Windspeed"
        case 4:
            return "Pressure"
        case 5:
            return "Ozone"
        case 6:
            return "Rain Chance"
        case 7:
            return "Rain Intense"
        case 8:
            return "Temperature"
        default:
            return "Temparature"
        }
    }
    
    //
    
    func getForecastContent (identifier: Int) -> [Float] {
        var values = [Float]()
        
        switch identifier {
        case 0:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].humidity!)
            }
            return values
        case 1:
            for i in 1...7 {
                values.append(Float(CurrentViewController.weather!.daily!.data![i].uvIndex!))
            }
            return values
        case 2:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].visibility!)
            }
            return values
        case 3:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].windSpeed!)
            }
            return values
        case 4:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].pressure!)
            }
            return values
        case 5:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].ozone!)
            }
            return values
        case 6:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].precipProbability!)
            }
            return values
        case 7:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].precipIntensity!)
            }
            return values
        case 8:
            for i in 1...7 {
                values.append(Float(CurrentViewController.weather!.daily!.data![i].sunriseTime!))
            }
            return values
        case 9:
            for i in 1...7 {
                values.append(Float(CurrentViewController.weather!.daily!.data![i].sunsetTime!))
            }
            return values
        case 10:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].temperatureMin!)
            }
            return values
        case 11:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].temperatureMax!)
            }
            return values
        default:
            for i in 1...7 {
                values.append(CurrentViewController.weather!.daily!.data![i].humidity!)
            }
            return values
        }
    }
    
    func getForecastTag(identifier: Int) -> String {
        switch identifier {
        case 0:
            return "Humidity"
        case 1:
            return "UV"
        case 2:
            return "Visibility"
        case 3:
            return "Windspeed"
        case 4:
            return "Pressure"
        case 5:
            return "Ozone"
        case 6:
            return "Rain Chance"
        case 7:
            return "Rain Intense"
        case 8:
            return "Sunrise Time"
        case 9:
            return "Sunset Time"
        case 10:
            return "Temperature Min"
        case 11:
            return "Temperature Max"
        default:
            return "Humidity"
        }
    }
    
    //
    
    func getHistoryContent (weatherArr: [Weather], identifier: Int) -> [Float] {
        var values = [Float]()
        
        switch identifier {
        case 0:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].humidity!)
            }
            return values
        case 1:
            for i in (0...6).reversed() {
                values.append(Float(weatherArr[i].daily!.data![0].uvIndex!))
            }
            return values
        case 2:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].visibility!)
            }
            return values
        case 3:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].windSpeed!)
            }
            return values
        case 4:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].pressure!)
            }
            return values
        case 5:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].ozone!)
            }
            return values
        case 6:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].precipProbability!)
            }
            return values
        case 7:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].precipIntensity!)
            }
            return values
        case 8:
            for i in (0...6).reversed() {
                values.append(Float(weatherArr[i].daily!.data![0].sunriseTime!))
            }
            return values
        case 9:
            for i in (0...6).reversed() {
                values.append(Float(weatherArr[i].daily!.data![0].sunsetTime!))
            }
            return values
        case 10:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].temperatureMin!)
            }
            return values
        case 11:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].temperatureMax!)
            }
            return values
        default:
            for i in (0...6).reversed() {
                values.append(weatherArr[i].daily!.data![0].humidity!)
            }
            return values
        }
    }
    
    func getHistoryTag(identifier: Int) -> String {
        switch identifier {
        case 0:
            return "Humidity"
        case 1:
            return "UV"
        case 2:
            return "Visibility"
        case 3:
            return "Windspeed"
        case 4:
            return "Pressure"
        case 5:
            return "Ozone"
        case 6:
            return "Rain Chance"
        case 7:
            return "Rain Intense"
        case 8:
            return "Sunrise Time"
        case 9:
            return "Sunset Time"
        case 10:
            return "Temperature Low"
        case 11:
            return "Temperature High"
        default:
            return "Humidity"
        }
    }
    
    func hourTimeInfo() -> [Double] {
        var timestamps = [Double]()
        for i in 0...23 {
            timestamps.append(CurrentViewController.weather!.hourly!.data![i].time!)
        }
        return timestamps
    }
    
    func forecastTimeInfo() -> [Double] {
        var timestamps = [Double]()
        for i in 1...7 {
            timestamps.append(CurrentViewController.weather!.daily!.data![i].time!)
        }
        return timestamps
    }
    
    func historyTimeInfo(weatherArr: [Weather]) -> [Double] {
        var timestamps = [Double]()
        for i in (0...6).reversed() {
            timestamps.append(weatherArr[i].daily!.data![0].time!)
        }
        return timestamps
    }
}
