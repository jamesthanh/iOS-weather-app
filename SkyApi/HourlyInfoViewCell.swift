/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Author: HOANG, Quang HUY
 ID: s3623383
 Created date: 21/09/2018
 Acknowledgment:
 */

import UIKit

class HourlyInfoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoData: UILabel!
    // show data for tableview.
    func showData(forRow: Int, index: Int){
        switch index {
        case 0:
            infoIcon.image = UIImage(named: "humidity")
            infoData.text = String(Int(CurrentViewController.weather!.hourly!.data![forRow].humidity! * 100)) + " %"
            break
        case 1:
            infoIcon.image = UIImage(named: "UV")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].uvIndex!)
            break
        case 2:
            infoIcon.image = UIImage(named: "visibility")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].visibility!)
            break
        case 3:
            infoIcon.image = UIImage(named: "windspeed")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].windSpeed!)
            break
        case 4:
            infoIcon.image = UIImage(named: "pressure")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].pressure!)
            break
        case 5:
            infoIcon.image = UIImage(named: "ozone")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].ozone!)
            break
        case 6:
            infoIcon.image = UIImage(named: "rain-chance")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].precipProbability! * 100) + "%"
            break
        case 7:
            infoIcon.image = UIImage(named: "rain-intense")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].precipIntensity!)
            break
        case 8:
            infoIcon.image = UIImage(named: "mid-temp")
            infoData.text = String(CurrentViewController.weather!.hourly!.data![forRow].temperature!) + "\u{00B0}F"
            break
        default:
            infoIcon.image = UIImage(named: "UV")
            infoData.text = String(CurrentViewController.weather!.currently!.uvIndex!)
            break
        }
    }
}
