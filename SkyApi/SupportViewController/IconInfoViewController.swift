/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Authors:
 LE, Minh Truyen (s3627577)
 HOANG, Quang Huy (s3623383)
 DUONG, Huu Khang (s3635116)
 NGUYEN, Tan Thanh (s3634815)
 Created date: 21/09/2018
 Acknowledgment:
 */
 

import UIKit

class IconInfoViewController: UITableViewController {

    let iconID =  [ "humidity", "windspeed", "visibility", "UV", "pressure", "ozone", "rain-chance", "rain-intense", "sundown", "sunup", "min-temp", "max-temp"]
    let descrip = [ "Humidity", "Wind Speed", "Visibility", "UV", "Pressure", "Ozone", "Rain Chance", "Rain Intense", "Sunset", "Sunrise", "Minimum Temperature", "Maximum Temperature"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "treemist")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return iconID.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconInfo", for: indexPath)
        cell.imageView?.image = UIImage(named: iconID[indexPath.row])
        cell.textLabel?.text = descrip[indexPath.row]
        return cell
    }
}
