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
import CoreLocation

class CurrentViewController: UIViewController, CLLocationManagerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, CurrentControllerDelegate, LocationHandlerDelegate {
    
    let currentController = CurrentController()
    let locationHandler = LocationHandler()
    let locationManager = CLLocationManager()
    static var weather : Weather?
    
    @IBOutlet weak var locationInfoTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var timeTxt: UILabel!
    @IBOutlet weak var temperatureTxt: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var movingCloud: UIImageView!
    @IBOutlet weak var lightMovingCloud: UIImageView!
    @IBOutlet weak var bigMovingCloud: UIImageView!
    
    func animatedCloud() {
        
        self.movingCloud.layer.removeAllAnimations()
        self.lightMovingCloud.layer.removeAllAnimations()
        self.bigMovingCloud.layer.removeAllAnimations()
        
        self.movingCloud.transform = CGAffineTransform.identity
        self.lightMovingCloud.transform = CGAffineTransform.identity
        self.bigMovingCloud.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 30, delay: 0, options: [.curveLinear, .repeat], animations: {
            print("sth")
            let x = self.view.frame.width + self.movingCloud.frame.width
            self.movingCloud.transform = CGAffineTransform(translationX: x, y: 0)
        })
        UIView.animate(withDuration: 50, delay: 0, options: [.curveLinear, .repeat], animations: {
            let w = self.view.frame.width + self.movingCloud.frame.width
            self.lightMovingCloud.transform = CGAffineTransform(translationX: w, y: 0)
        })
        UIView.animate(withDuration: 100, delay: 0, options: [.curveLinear, .repeat], animations: {
            let w = self.view.frame.width + self.movingCloud.frame.width
            self.bigMovingCloud.transform = CGAffineTransform(translationX: w, y: 0)
        })
    }
    
    func locationRefreshed(currentLat latitude : Double, currentLong longitude : Double) {
        currentController.fetchData(currentLat: latitude, currentLong: longitude)
    }
    
    func addCityInfo(city: City) {
        if let locality = LocationHandler.cityInfo!.locality {
            self.locationInfoTxt.text = locality + ", " + LocationHandler.cityInfo!.country!
        } else if let country = LocationHandler.cityInfo!.country {
            self.locationInfoTxt.text = country
        } else {
            self.locationInfoTxt.text = LocationHandler.cityInfo!.name!
        }
        
    }
    
    func fetchSuccess(weather newWeather: Weather) {
        
        DispatchQueue.main.async {
            CurrentViewController.weather = newWeather
            
            //Time format
            let time = TimeInfo(timestamp: CurrentViewController.weather!.currently!.time!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
            self.dateTxt.text = time.weekday + ", " + time.date
            self.timeTxt.text = time.hour + ":" + time.minute
            if let hour = Int(time.hour){
                if hour >= 6 && hour <= 18 {
                    self.background.image = UIImage(named: "bg")
                    self.movingCloud.alpha = 1
                    self.lightMovingCloud.alpha = 1
                    self.bigMovingCloud.alpha = 0.8
                } else {
                    self.background.image = UIImage(named: "night-bg")
                    self.movingCloud.alpha = 0.6
                    self.lightMovingCloud.alpha = 0.6
                    self.bigMovingCloud.alpha = 0.6
                }
            }
            self.reloadData()
        }
        
    }
    
    func reloadData () {
        self.temperatureTxt.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.currently!.temperature!))) + "\u{00B0}C | " + String(Int(CurrentViewController.weather!.currently!.temperature!)) + "\u{00B0}F"
        self.weatherIcon.image = UIImage(named: WeatherInfo.iconFinder(icon: CurrentViewController.weather!.currently!.icon!))
        self.summary.text = CurrentViewController.weather!.currently!.summary!
        self.tableView.reloadData()
        if CurrentViewController.weather != nil {
        self.indicator.stopAnimating()
        self.indicator.hidesWhenStopped = true
        UIApplication.shared.endIgnoringInteractionEvents()
        } else {
        self.locationManager.startUpdatingLocation()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        //Delegate
        locationHandler.delegate = self
        currentController.delegate = self
        
        //Initialize location
        if CurrentViewController.weather == nil {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        indicator.startAnimating()
    }
    
    //MARK: -Location Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location")
        if let currentLocation = locations.last {
            locationHandler.locationSelected(location: currentLocation)
        } else {
            locationHandler.locationSelected(location: CLLocation(latitude: 10.7835601140853, longitude: 106.6945260001))
        }
        locationManager.stopUpdatingLocation()
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedCloud()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RefreshTapped(_ sender: Any) {

        locationManager.startUpdatingLocation()
        indicator.startAnimating()
        if CurrentViewController.weather == nil {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    //MARK: -Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currentInfoCell", for: indexPath) as! CurrentInfoViewCell
        if CurrentViewController.weather != nil {
            cell.showData(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -80, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 0.7) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}


