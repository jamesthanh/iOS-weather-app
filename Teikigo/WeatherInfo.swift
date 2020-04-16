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

// this class contains the logics to convert the basic data of the app.

import Foundation

class WeatherInfo {
    // create constants 
    static let C_TO_F: Float = 1.8
    static let F_AT_ZERO_C: Float = 32
    
    static func toCelcius (degreeFahrenheit : Float) -> Float {
        return (degreeFahrenheit - F_AT_ZERO_C) / C_TO_F
    }
    // set the identifier to keep track of the icons
    static func iconFinder (icon: String) -> String {
        if icon.contains("clear-day"){
            return "clear-day"
        } else if icon.contains("clear-night"){
            return "clear-night"
        } else if icon == "cloudy" {
            return "cloudy"
        } else if icon.contains("fog") {
            return "fog"
        } else if icon.contains("hail"){
            return "hail"
        } else if icon.contains("cloudy-day"){
            return "partly-cloudy-day"
        } else if icon.contains("cloudy-night"){
            return "partly-cloudy-night"
        } else if icon.contains("rain"){
            return "rain"
        } else if icon.contains("sleet"){
            return "sleet"
        } else if icon.contains("snow") {
            return "snow"
        } else if icon.contains("thunderstorm"){
            return "thunderstorm"
        } else if icon.contains("tornado"){
            return "tornado"
        } else if icon.contains("wind"){
            return "wind"
        } else {
            return "default"
        }
    }
}
