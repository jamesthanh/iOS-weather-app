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

class HourlyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    let controller = GraphController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        // Do any additional setup after loading the view.
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //MARK: -segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "graph" {
            let controller = segue.destination as! GraphViewController
            controller.values = self.controller.getHourContent(identifier: collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!.tag)
            controller.tag = self.controller.getHourTag(identifier: collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!.tag)
            controller.timeInfo = self.controller.hourTimeInfo()
            controller.isHourly = true
        }
    }
    
    //MARK: -TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell", for: indexPath) as! HourlyViewCell
        let time = TimeInfo(timestamp: CurrentViewController.weather!.hourly!.data![indexPath.row].time!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
        cell.hourLabel?.text = time.hour + ":" + time.minute
        cell.hourSummary?.text = CurrentViewController.weather!.hourly!.data![indexPath.row].summary!
        cell.hourIconImage?.image = UIImage(named: WeatherInfo.iconFinder(icon: CurrentViewController.weather!.hourly!.data![indexPath.row].icon!))
        cell.hourTempC?.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.hourly!.data![indexPath.row].temperature!))) + "\u{00B0}C"
        cell.hourAppaTemp?.text = "~" + String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.hourly!.data![indexPath.row].apparentTemperature!))) + "\u{00B0}C"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyInfoCell", for: indexPath) as! HourlyInfoViewCell
        cell.tag = indexPath.row
        cell.showData(forRow: collectionView.tag ,index: indexPath.row)
        return cell
        
    }
    
    func reloadDate (index: Int) {
        let time = TimeInfo(timestamp: CurrentViewController.weather!.hourly!.data![index].time!, timeZone: LocationHandler.cityInfo.timeZone!)
        self.dateLabel.text = time.date
        self.timeLabel.text = time.hour + ":" + time.minute
    }
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.isPagingEnabled = true
        collectionView.reloadData()
        reloadDate(index: row)
    }
    
}
