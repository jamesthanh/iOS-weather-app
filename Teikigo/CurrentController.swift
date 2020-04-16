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

// this class contains the logics to handle current, hourly and forcast weather info.

import Foundation

protocol CurrentControllerDelegate : class {
    func fetchSuccess (weather newWeather : Weather)
}

class CurrentController:  NSObject {
    // create the deliagte for the class.
    weak var delegate : CurrentControllerDelegate?
    // fetch data from the link
    func fetchData (currentLat latitude : Double, currentLong longitude : Double){
        let urlString = "https://api.darksky.net/forecast/e96b48fdb95327188701d3d865463bca/" + String(latitude) + "," + String(longitude)
        print(urlString)
        if let url = URL(string : urlString) {
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
// print(String(data: data!, encoding: .ascii) ?? "no")
                if let newData = data {
                    if let newWeather = try? JSONDecoder().decode(Weather.self, from: newData){
                        if newWeather.timezone != nil {
                            self.delegate?.fetchSuccess (weather : newWeather)
                            print(newWeather.currently!.time!)
                        }
                    }
                }
                
                
            })
            task.resume()
        }
    }
    
}
