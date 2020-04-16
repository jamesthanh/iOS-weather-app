/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Author: NGUYEN, Tan Thanh
 ID: s3634815
 Created date: 21/09/2018
 Acknowledgment:
 */

import UIKit

class ForecastInfoViewCell: UICollectionViewCell {
    // create connections
    @IBOutlet weak var dataValue: UILabel!
    @IBOutlet weak var infoIcon: UIImageView!
    // show data with imgs.
    func showData(forRow: Int, index: Int){
        switch index {
        case 0:
            infoIcon.image = UIImage(named: "humidity")
            dataValue.text = String(Int(CurrentViewController.weather!.daily!.data![forRow].humidity! * 100)) + " %"
            break
        case 1:
            infoIcon.image = UIImage(named: "UV")
            dataValue.text = String(CurrentViewController.weather!.daily!.data![forRow].uvIndex!)
            break
        case 2:
            infoIcon.image = UIImage(named: "visibility")
            dataValue.text = String(CurrentViewController.weather!.daily!.data![forRow].visibility!)
            break
        case 3:
            infoIcon.image = UIImage(named: "windspeed")
            dataValue.text = String(CurrentViewController.weather!.daily!.data![forRow].windSpeed!)
            break
        case 4:
            infoIcon.image = UIImage(named: "pressure")
            dataValue.text = String(CurrentViewController.weather!.daily!.data![forRow].pressure!)
            break
        case 5:
            infoIcon.image = UIImage(named: "ozone")
            dataValue.text = String(CurrentViewController.weather!.daily!.data![forRow].ozone!)
            break
        case 6:
            infoIcon.image = UIImage(named: "rain-chance")
            dataValue.text = String(CurrentViewController.weather!.daily!.data![forRow].precipProbability! * 100) + "%"
            break
        case 7:
            infoIcon.image = UIImage(named: "rain-intense")
            dataValue.text = String(CurrentViewController.weather!.daily!.data![forRow].precipIntensity!)
            break
            
        case 8:
            infoIcon.image = UIImage(named: "sunup")
            let time = TimeInfo(timestamp: CurrentViewController.weather!.daily!.data![forRow].sunriseTime!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
            dataValue.text = time.hour + ":" + time.minute
            break
            
        case 9:
            infoIcon.image = UIImage(named: "sundown")
            let time = TimeInfo(timestamp: CurrentViewController.weather!.daily!.data![forRow].sunsetTime!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
            dataValue.text = time.hour + ":" + time.minute
            break
        case 10:
            infoIcon.image = UIImage(named: "min-temp")
            dataValue.text = String(Int(CurrentViewController.weather!.daily!.data![forRow].temperatureMin!)) + "\u{00B0}F"
            break
        case 11:
            infoIcon.image = UIImage(named: "max-temp")
            dataValue.text = String(Int(CurrentViewController.weather!.daily!.data![forRow].temperatureMax!)) + "\u{00B0}F"
            break
            
        default:
            break
        }
    }
}
