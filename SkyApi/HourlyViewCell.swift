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

class HourlyViewCell: UITableViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourSummary: UILabel!
    @IBOutlet weak var hourIconImage: UIImageView!
    @IBOutlet weak var hourTempC: UILabel!
    @IBOutlet weak var hourAppaTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
