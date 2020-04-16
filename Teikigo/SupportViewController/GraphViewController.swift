/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Authors:
 HOANG, Quang Huy (s3623383)
 DUONG, Huu Khang (s3635116)
 NGUYEN, Tan Thanh (s3634815)
 Created date: 21/09/2018
 Acknowledgment:
 */


// this class handles the logics to handle graphing tasks.

import UIKit

protocol GraphViewControllerDelegate : class {
    func setGarphValues (values: [Float])
}

class GraphViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var delegate : GraphViewControllerDelegate?
    var values : [Float]!
    var timeInfo : [Double]!
    var tag : String!
    var isHourly : Bool!
    
    @IBOutlet weak var graphView: GraphView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.title = self.tag
        navigationItem.title = self.tag
        // Do any additional setup after loading the view.
        print(self.tag)
        if tag.contains("Time"){
            var timeData = [Float]()
            for i in 0...values.count - 1 {
                let time = TimeInfo(timestamp: Double(values[i]), timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
                timeData.append(Float(time.hour)! * 60 + Float(time.minute)!)
            }
            graphView.setGarphValues(values: timeData)
        } else  {
            graphView.setGarphValues(values: values)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        if let index = tableView.indexPathForSelectedRow {
            tableView.cellForRow(at: index)?.textLabel?.textColor = UIColor.black
            tableView.cellForRow(at: index)?.detailTextLabel?.textColor = UIColor.black
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: -TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "graphCell", for: indexPath)
        let time = TimeInfo(timestamp: timeInfo[indexPath.row], timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
        if isHourly {
            cell.textLabel?.text = time.hour + ":" + time.minute
        } else {
            cell.textLabel?.text = time.date
        }
        
        if tag.contains("Time"){
            let timeData = TimeInfo(timestamp: Double(values[indexPath.row]), timeZone: TimeZone(identifier: CurrentViewController.weather!.timezone!)!)
            cell.detailTextLabel?.text = timeData.hour + ":" + timeData.minute
        } else  {
            cell.detailTextLabel?.text = String(self.values[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        graphView.touchPoint = indexPath.row
        graphView.setNeedsDisplay()
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
        tableView.cellForRow(at: indexPath)?.detailTextLabel?.textColor = UIColor.black
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.white
        tableView.cellForRow(at: indexPath)?.detailTextLabel?.textColor = UIColor.white
    }
}
