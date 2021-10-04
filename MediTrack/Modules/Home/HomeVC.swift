import UIKit
import CoreData

class HomeVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var wishingLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var medicineButton: UIButton!
    
    //MARK:- Class properties
    
    private var presenter: HomePresenter!

    //MARK:- View life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter.onViewAppear()
    }
    
    //MARK:- IBActions

    @IBAction func onPressMedicineTaken(_ sender: UIButton) {
        presenter.onPressButton()
    }
    
    @objc func showHistoryVC() {
        showHistory()
    }
}

//MARK:- HomePresenterDelegate methods

extension HomeVC: HomePresenterDelegate {
    func showHistoryScreen() {
        showHistoryVC()
    }
    
    func setUpUI() {
        self.navigationItem.title = StoryBoardName.Home.rawValue
        
        /// Currently just added the corner radius logic here as the button is only used once in project,
        /// if there mutliple used, then create a subclass of UIButton with customisations
        medicineButton.layer.cornerRadius = 15.0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(showHistoryVC))
    }

    func setData() {
        self.scoreLabel.text = presenter.getScore()
        self.scoreLabel.textColor = presenter.getScoreColor()
        self.wishingLabel.text = presenter.getWishingText()
        self.medicineButton.setTitle(presenter.getButtonText(), for: .normal)
    }
}

