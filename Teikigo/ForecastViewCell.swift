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
// class contains cell info for the forecast tap

import UIKit

class ForecastViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var maxTem: UILabel!
    @IBOutlet weak var minTem: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
