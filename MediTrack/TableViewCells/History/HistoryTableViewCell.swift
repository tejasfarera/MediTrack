import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
    struct DataSource {
        let afternoonTime: String
        let morningTime: String
        let eveningTime: String
        let date: String
        let score: Int
    }
    
    @IBOutlet weak var morningStackView: UIStackView!
    @IBOutlet weak var afternoonStackView: UIStackView!
    @IBOutlet weak var eveningStackView: UIStackView!
    
    @IBOutlet weak var morningTimeLabel: UILabel!
    @IBOutlet weak var afternoonTimeLabel: UILabel!
    @IBOutlet weak var eveningTimeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
