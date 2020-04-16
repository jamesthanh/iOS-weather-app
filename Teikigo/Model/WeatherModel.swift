/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Authors: LE, Minh Truyen (s3627577)
 HOANG, Quang Huy (s3623383)
 DUONG, Huu Khang (s3635116)
 NGUYEN, Tan Thanh (s3634815)
 Created date: 21/09/2018
 Acknowledgment: 
 */

// this class contains model of weather based on the given api.

import Foundation

class Currently : Codable {
    var time : Double?
    var summary : String?
    var icon : String?
    var nearestStormDistance : Float?
    var nearestStormBearing : Float?
    var precipIntensity : Float?
    var precipProbability : Float?
    var temperature : Float?
    var apparentTemperature : Float?
    var dewPoint : Float?
    var humidity : Float?
    var pressure : Float?
    var windSpeed : Float?
    var windGust : Float?
    var windBearing : Float?
    var cloudCover : Float?
    var uvIndex : Int?
    var visibility : Float?
    var ozone : Float?
}

class MinutelyData : Codable {
    var time : Double?
    var precipIntensity : Float?
    var precipProbability : Float?
    
}

class Minutely: Codable {
    var summary : String?
    var icon : String?
    var data : [MinutelyData]?
    
}

class HourlyData : Codable {
    var time : Double?
    var summary : String?
    var icon : String?
    var precipIntensity : Float?
    var precipProbability : Float?
    var temperature : Float?
    var apparentTemperature : Float?
    var dewPoint : Float?
    var humidity : Float?
    var pressure : Float?
    var windSpeed : Float?
    var windGust : Float?
    var windBearing : Float?
    var cloudCover : Float?
    var uvIndex : Int?
    var visibility : Float?
    var ozone : Float?
}

class Hourly : Codable {
    var summary : String?
    var icon : String?
    var data: [HourlyData]?
}

class DailyData : Codable {
    var time : Double?
    var summary : String?
    var icon : String?
    var sunriseTime : Double?
    var sunsetTime : Double?
    var moonPhase : Float?
    var precipIntensity : Float?
    var precipIntensityMax : Float?
    var precipIntensityMaxTime : Double?
    var precipProbability : Float?
    var precipType : String?
    var temperatureHigh : Float?
    var temperatureHighTime : Double?
    var temperatureLow : Float?
    var temperatureLowTime : Double?
    var apparentTemperatureHigh : Float?
    var apparentTemperatureHighTime : Double?
    var apparentTemperatureLow : Float?
    var apparentTemperatureLowTime : Double?
    var dewPoint : Float?
    var humidity : Float?
    var pressure : Float?
    var windSpeed :Float?
    var windGust : Float?
    var windGustTime : Double?
    var windBearing : Float?
    var cloudCover : Float?
    var uvIndex : Int?
    var uvIndexTime : Double?
    var visibility : Float?
    var ozone : Float?
    var temperatureMin : Float?
    var temperatureMinTime : Double?
    var temperatureMax : Float?
    var temperatureMaxTime : Double?
    var apparentTemperatureMin : Float?
    var apparentTemperatureMinTime : Double?
    var apparentTemperatureMax : Float?
    var apparentTemperatureMaxTime : Double?
}

class Daily : Codable {
    var summary : String?
    var icon : String?
    var data : [DailyData]?
}

class Weather : Codable {
    var latitude : Double?
    var longitude : Double?
    var timezone : String?
    var currently : Currently?
    var minutely : Minutely?
    var hourly : Hourly?
    var daily : Daily?
}
