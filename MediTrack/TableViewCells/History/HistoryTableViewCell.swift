import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
    struct DataSource {
        let afternoonTime: String
        let morningTime: String
        let eveningTime: String
        let date: String
        let score: Int
        let scoreColor: UIColor
        
        init(displayableDoseModel: DisplayableDoseModel) {
            self.date = displayableDoseModel.dateString
            self.score = DoseTiming.getScore(timingsInString: displayableDoseModel.doseModels)
            self.scoreColor = DoseTiming.getColor(score: self.score)
            
            self.morningTime = displayableDoseModel.doseModels.first{ $0.doseTiming == .morning }?.date.time ?? ""
            self.afternoonTime = displayableDoseModel.doseModels.first{ $0.doseTiming == .noon }?.date.time ?? ""
            self.eveningTime = displayableDoseModel.doseModels.first{ $0.doseTiming == .evening }?.date.time ?? ""
        }
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
        
        self.contentView.subviews.first?.layer.borderWidth = 1
        self.contentView.subviews.first?.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayData(dataSource: DataSource) {
        self.scoreLabel.text = dataSource.score.description
        self.dateLabel.text = dataSource.date
        self.morningTimeLabel.text = dataSource.morningTime
        self.afternoonTimeLabel.text = dataSource.afternoonTime
        self.eveningTimeLabel.text = dataSource.eveningTime
        
        self.morningStackView.isHidden = dataSource.morningTime.isEmpty
        self.afternoonStackView.isHidden = dataSource.afternoonTime.isEmpty
        self.eveningStackView.isHidden = dataSource.eveningTime.isEmpty
        
        self.scoreLabel.textColor = dataSource.scoreColor
    }
}

