import UIKit

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
    }


    @IBAction func onPressMedicineTaken(_ sender: UIButton) {
        showHistory()
    }
}



enum ScoringColor {
    case red
    case orange
    case green
    
    func getTextColor() -> UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .orange:
            return UIColor.orange
        case .green:
            return UIColor.green
        }
    }
}


extension UIViewController {
    func showHistory() {
        guard let historyVC = StoryBoardName.History.getInitialViewController() as? HistoryVC else {
            debugPrint("Can't find HistoryVC")
            return
        }
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
}

enum StoryBoardName: String {
    case Home
    case History
    
    func getInitialViewController() -> UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: self.rawValue + "VC")
    }
}
