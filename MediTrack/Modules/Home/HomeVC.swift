import UIKit
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var wishingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var medicineButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = StoryBoardName.Home.rawValue
        
        /// Currently just added the corner radius logic here as the button is only used once in project,
        /// if there mutliple used, then create a subclass of UIButton with customisations
        medicineButton.layer.cornerRadius = 15.0
        
        self.setData()
    }

    private func setData() {
        self.wishingLabel.text = DoseTiming.getDoseTiming().wishingText
        self.scoreLabel.text = DoseTiming.getDoseTiming().points.description
        
        self.scoreLabel.textColor = DoseTiming.getColor(score: DoseTiming.getDoseTiming().points)
        
    }

    @IBAction func onPressMedicineTaken(_ sender: UIButton) {
        CoreDataManager.shared.saveDose(doseModel: DoseModel(doseTiming: .morning, date: Date().addingTimeInterval(TimeInterval(Constants.secondsInHour * 13))))
        showHistory()
    }
}



