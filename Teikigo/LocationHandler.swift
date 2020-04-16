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

// this class contains the logics to handle the location tasks of the app.

import Foundation
import CoreLocation


protocol LocationHandlerDelegate : class {
    func locationRefreshed(currentLat latitude : Double, currentLong longitude : Double)
    func addCityInfo(city: City)
}

class LocationHandler : NSObject, CLLocationManagerDelegate {
    // create location deligate.
    weak var delegate : LocationHandlerDelegate?
    let RANDOM_SMALL_NUM = 0.000001
    static var location : CLLocation!
    static var cityInfo : City!
    static var timeInfo : TimeInfo!

    
    // select location
    func locationSelected (location newLocation : CLLocation) {
        LocationHandler.location = newLocation
        CLGeocoder().reverseGeocodeLocation(LocationHandler.location!, completionHandler: { (placemarks, error) in
            if let placemark = placemarks?.first {
                LocationHandler.cityInfo = City(placemark: placemark)
                let city = LocationHandler.cityInfo?.name
                print(city!)
                
                self.delegate?.addCityInfo(city: LocationHandler.cityInfo)
                
            }
            
        })
        print(LocationHandler.location!.coordinate.latitude + RANDOM_SMALL_NUM * Double(arc4random_uniform(9)))
        print(LocationHandler.location!.coordinate.longitude + RANDOM_SMALL_NUM * Double(arc4random_uniform(9)))
        self.delegate?.locationRefreshed(currentLat: LocationHandler.location!.coordinate.latitude + RANDOM_SMALL_NUM + RANDOM_SMALL_NUM * Double(arc4random_uniform(9)), currentLong: LocationHandler.location!.coordinate.longitude + RANDOM_SMALL_NUM + RANDOM_SMALL_NUM * Double(arc4random_uniform(9)))
    }
}
// create city model
struct City {
    var name : String?
    var country : String?
    var locality : String?
    var region : CLRegion?
    var timeZone : TimeZone?
    
    init(placemark: CLPlacemark) {
        self.name = placemark.name
        self.country = placemark.country
        self.locality = placemark.locality
        self.region = placemark.region
        self.timeZone = placemark.timeZone
    }
}
// create a time model
class TimeInfo {
    var weekday : String!
    var date : String!
    var hour : String!
    var minute :String!
    
    init(timestamp: Double, timeZone: TimeZone) {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormater = DateFormatter()
        dateFormater.timeZone = timeZone
        dateFormater.locale = Locale(identifier: "en_US")
        dateFormater.dateFormat = "dd MMM yyyy"
        self.date = dateFormater.string(from: date)
        dateFormater.dateFormat = "HH"
        self.hour = dateFormater.string(from: date)
        dateFormater.dateFormat = "mm"
        self.minute = dateFormater.string(from: date)
        dateFormater.dateFormat = "EEE"
        self.weekday = dateFormater.string(from: date)
        
    }
}


