/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Author: LE, Minh Truyen
 ID: s3627577
 Created date: 21/09/2018
 
 Acknowledgment:
 
 */


import UIKit

class CurrentInfoViewCell: UITableViewCell {

    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoType: UILabel!
    
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // display data
    func showData(index: Int) {
        switch index {
        case 0:
            infoIcon.image = UIImage(named: "mid-temp")
            infoType.text = "Real Feel: "
            value.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.currently!.apparentTemperature!))) + "\u{00B0}C"
            break
        case 2:
            infoIcon.image = UIImage(named: "min-temp")
            infoType.text = "Minimum: "
            value.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.daily!.data![0].temperatureMin!))) + "\u{00B0}C"
            break
        case 4:
            infoIcon.image = UIImage(named: "max-temp")
            infoType.text = "Maximum: "
            value.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.daily!.data![0].temperatureMax!))) + "\u{00B0}C"
            break
        case 1:
            infoIcon.image = UIImage(named: "mid-temp")
            infoType.text = "Real Feel: "
            value.text = String(Int(CurrentViewController.weather!.currently!.apparentTemperature!)) + "\u{00B0}F"
            break
        case 3:
            infoIcon.image = UIImage(named: "min-temp")
            infoType.text = "Minimum: "
            value.text = String(Int(CurrentViewController.weather!.daily!.data![0].temperatureMin!)) + "\u{00B0}F"
            break
        case 5:
            infoIcon.image = UIImage(named: "max-temp")
            infoType.text = "Maximum: "
            value.text = String(Int(CurrentViewController.weather!.daily!.data![0].temperatureMax!)) + "\u{00B0}F"
            break
        case 6:
            infoIcon.image = UIImage(named: "sunup")
            infoType.text = "Sunrise: "
            let time = TimeInfo(timestamp: CurrentViewController.weather!.daily!.data![0].sunriseTime!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
            value.text = time.hour + ":" + time.minute
            break
        case 7:
            infoIcon.image = UIImage(named: "sundown")
            infoType.text = "Sunset: "
            let time = TimeInfo(timestamp: CurrentViewController.weather!.daily!.data![0].sunsetTime!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
            value.text = time.hour + ":" + time.minute
            break
        case 8:
            infoIcon.image = UIImage(named: "humidity")
            infoType.text = "Humidity: "
            value.text = String(Int(CurrentViewController.weather!.currently!.humidity! * 100)) + " %"
            break
        case 9:
            infoIcon.image = UIImage(named: "rain-chance")
            infoType.text = "Rain Chance: "
            value.text = String(Int(CurrentViewController.weather!.currently!.precipProbability! * 100)) + " %"
            break
        case 10:
            infoIcon.image = UIImage(named: "rain-intense")
            infoType.text = "Rain Intensity: "
            value.text = String(CurrentViewController.weather!.currently!.precipProbability!) + " mm/h"
            break
        case 11:
            infoIcon.image = UIImage(named: "windspeed")
            infoType.text = "Wind Speed: "
            value.text = String(CurrentViewController.weather!.currently!.windSpeed!) + " km/h"
            break
        case 12:
            infoIcon.image = UIImage(named: "UV")
            infoType.text = "UV Index: "
            value.text = String(CurrentViewController.weather!.currently!.uvIndex!)
            break
        case 13:
            infoIcon.image = UIImage(named: "pressure")
            infoType.text = "Pressure: "
            value.text = String(Int(CurrentViewController.weather!.currently!.pressure!)) + " mb"
            break
        case 14:
            infoIcon.image = UIImage(named: "visibility")
            infoType.text = "Visibility: "
            value.text = String(CurrentViewController.weather!.currently!.visibility!)
            break
        case 15:
            infoIcon.image = UIImage(named: "ozone")
            infoType.text = "Ozone: "
            value.text = String(CurrentViewController.weather!.currently!.ozone!)
            break
        default:
            infoIcon.image = UIImage(named: "default")
            infoType.text = "Updating..."
            value.text = "..."
            break
        }
    }

}
