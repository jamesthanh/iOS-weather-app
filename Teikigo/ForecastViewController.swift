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

class ForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let controller = GraphController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        // Do any additional setup after loading the view.
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "graph" {
            let controller = segue.destination as! GraphViewController
            controller.values = self.controller.getForecastContent(identifier: collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!.tag)
            controller.tag = self.controller.getForecastTag(identifier: collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!.tag)
            controller.timeInfo = self.controller.forecastTimeInfo()
            controller.isHourly = false
        }
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! ForecastViewCell
        cell.dateLabel.text = TimeInfo(timestamp: CurrentViewController.weather!.daily!.data![indexPath.row + 1].time!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!).date
        cell.summaryLabel.text = CurrentViewController.weather!.daily!.data![indexPath.row + 1].summary!
        cell.iconImg.image = UIImage(named: CurrentViewController.weather!.daily!.data![indexPath.row + 1].icon!)
        cell.minTem.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.daily!.data![indexPath.row + 1].temperatureMin!))) + "\u{00B0}C"
        cell.maxTem.text = String(Int(WeatherInfo.toCelcius(degreeFahrenheit: CurrentViewController.weather!.daily!.data![indexPath.row + 1].temperatureMax!))) + "\u{00B0}C"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row + 1)
    }

    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastInfoCell", for: indexPath) as! ForecastInfoViewCell
        cell.showData(forRow: collectionView.tag, index: indexPath.row)
        cell.tag = indexPath.row
        return cell
    }
    
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.isPagingEnabled = true
        collectionView.reloadData()
        self.dateLabel.text = TimeInfo(timestamp: CurrentViewController.weather!.daily!.data![row].time!, timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!).date
    }
}
