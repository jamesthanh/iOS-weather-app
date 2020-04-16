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

import UIKit

class HistoryDetailCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
}

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, HistoryControllerDelegate {
    @IBOutlet weak var topDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let controller = GraphController()
    let historyController = HistoryController()
    var weatherArr: [Weather]?
    var lastLat: Double?
    var lastLong: Double?
    var indicator = UIActivityIndicatorView()
    
    func waitingIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.backgroundColor = UIColor.clear
        indicator.color = UIColor.white
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func didFetchHistory(weatherArr newWeatherArr: [Weather]) {
        self.weatherArr = newWeatherArr
        
        for weather in newWeatherArr {
            print("From didFetchHistory")
            let date = Date(timeIntervalSince1970: Double(weather.daily!.data![0].time!))
            print("\(date)")
            print(weather.daily!.data![0].icon!)
            print(weather.daily!.data![0].apparentTemperatureHigh!)
            print()
        }
        
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
            self.tableView.reloadData()
            self.setDataSourceDelegate(dataSourceDelegate: self, row: 0)
            self.topDateLabel.text = TimeInfo(timestamp: self.weatherArr![0].daily!.data![0].time!, timeZone: TimeZone(identifier: self.weatherArr![0].timezone!)!).date
            self.summaryLabel.text = String(describing: self.weatherArr![0].daily!.data![0].summary!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        tableView.delegate = self
        historyController.delegate = self
        waitingIndicator()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -80, 20, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (lastLat == nil || lastLong == nil) || (lastLat != LocationHandler.location?.coordinate.latitude || lastLong != LocationHandler.location?.coordinate.longitude) {
            weatherArr = [Weather]()
            tableView.reloadData()
            topDateLabel.text = ""
            summaryLabel.text = ""
            indicator.startAnimating()
            lastLat = LocationHandler.location?.coordinate.latitude
            lastLong = LocationHandler.location?.coordinate.longitude
            historyController.fetchHistory(currentLat: lastLat!, currentLong: lastLong!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "graph" {
            let controller = segue.destination as! GraphViewController
            controller.values = self.controller.getHistoryContent(weatherArr: weatherArr!, identifier: collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!.tag)
            controller.tag = String(self.controller.getHistoryTag(identifier: collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!.tag))
            controller.timeInfo = self.controller.historyTimeInfo(weatherArr: weatherArr!)
            controller.isHourly = false
        }
    }
    
    // MARK: - Collection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let historyDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyDetailCell", for: indexPath) as! HistoryDetailCell
        switch indexPath.row {
        case 0:
            historyDetailCell.image.image = UIImage(named: "humidity")
            historyDetailCell.infoLabel.text = String(describing: weatherArr![collectionView.tag].daily!.data![0].humidity!)
            break
        case 1:
            historyDetailCell.image.image = UIImage(named: "UV")
            historyDetailCell.infoLabel.text = String(describing: weatherArr![collectionView.tag].daily!.data![0].uvIndex!)
            break
        case 2:
            historyDetailCell.image.image = UIImage(named: "visibility")
            historyDetailCell.infoLabel.text = String(describing: weatherArr![collectionView.tag].daily!.data![0].visibility!)
            break
        case 3:
            historyDetailCell.image.image = UIImage(named: "windspeed")
            historyDetailCell.infoLabel.text = String(describing: weatherArr![collectionView.tag].daily!.data![0].windSpeed!)
            break
        case 4:
            historyDetailCell.image.image = UIImage(named: "pressure")
            historyDetailCell.infoLabel.text = String(describing: weatherArr![collectionView.tag].daily!.data![0].pressure!)
            break
        case 5:
            historyDetailCell.image.image = UIImage(named: "ozone")
            historyDetailCell.infoLabel.text = String(describing: weatherArr![collectionView.tag].daily!.data![0].ozone!)
            break
        case 6:
            historyDetailCell.image.image = UIImage(named: "rain-chance")
            historyDetailCell.infoLabel.text = String(weatherArr![collectionView.tag].daily!.data![0].precipProbability! * 100) + "%"
            break
        case 7:
            historyDetailCell.image.image = UIImage(named: "rain-intense")
            historyDetailCell.infoLabel.text = String(weatherArr![collectionView.tag].daily!.data![0].precipIntensity!)
            break
            
        case 8:
            historyDetailCell.image.image = UIImage(named: "sunup")
            let time = TimeInfo(timestamp: weatherArr![collectionView.tag].daily!.data![0].sunriseTime!, timeZone: TimeZone(identifier: weatherArr![collectionView.tag].timezone!)!)
            historyDetailCell.infoLabel.text = time.hour + ":" + time.minute
            break
            
        case 9:
            historyDetailCell.image.image = UIImage(named: "sundown")
            let time = TimeInfo(timestamp: weatherArr![collectionView.tag].daily!.data![0].sunsetTime!, timeZone: TimeZone(identifier: weatherArr![collectionView.tag].timezone!)!)
            historyDetailCell.infoLabel.text = time.hour + ":" + time.minute
            break
        case 10:
            historyDetailCell.image.image = UIImage(named: "min-temp")
            historyDetailCell.infoLabel.text = String(Int(weatherArr![collectionView.tag].daily!.data![0].temperatureLow!)) + "\u{00B0}F"
            break
        case 11:
            historyDetailCell.image.image = UIImage(named: "max-temp")
            historyDetailCell.infoLabel.text = String(Int(weatherArr![collectionView.tag].daily!.data![0].temperatureHigh!)) + "\u{00B0}F"
            break
        default:
            historyDetailCell.image.image = UIImage(named: "default")
            historyDetailCell.infoLabel.text = "Updating"
            break
        }
        historyDetailCell.tag = indexPath.row
        return historyDetailCell
    }
    
    // MARK: - Table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        print("cell???")
        
        if weatherArr != nil {
            if weatherArr!.count != 0 {
                historyCell.dateLabel.text = String(describing: weatherArr![indexPath.row].daily!.data![0].time!)
                historyCell.dateLabel.text = TimeInfo(timestamp: weatherArr![indexPath.row].daily!.data![0].time!, timeZone: TimeZone(identifier: weatherArr![indexPath.row].timezone!)!).date
                historyCell.icon.image = UIImage(named: weatherArr![indexPath.row].daily!.data![0].icon!)
                historyCell.tempHighLabel.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: roundf(weatherArr![indexPath.row].daily!.data![0].temperatureHigh!))))  + "\u{00B0}C"
                historyCell.tempLowLabel.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: roundf(weatherArr![indexPath.row].daily!.data![0].temperatureLow!))))  + "\u{00B0}C"
                print("update table cell???")
                return historyCell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        topDateLabel.text = TimeInfo(timestamp: weatherArr![indexPath.row].daily!.data![0].time!, timeZone: TimeZone(identifier: weatherArr![indexPath.row].timezone!)!).date
        summaryLabel.text = String(describing: weatherArr![indexPath.row].daily!.data![0].summary!)
        setDataSourceDelegate(dataSourceDelegate: self, row: indexPath.row)
        print("Cell \(indexPath.row) tapped")
    }
    
    func setDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: D, row: Int) {
        collectionView.dataSource = dataSourceDelegate
        collectionView.delegate = dataSourceDelegate
        collectionView.tag = row
        collectionView.isPagingEnabled = true
        collectionView.reloadData()
    }

}
