import UIKit

class HistoryVC: UIViewController {

    @IBOutlet private weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = StoryBoardName.History.rawValue

        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        
        self.historyTableView.register(
            UINib(nibName: HistoryTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HistoryTableViewCell.identifier
        )
    }
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else {
            debugPrint("Can't type cast HistoryTableViewCell")
            return HistoryTableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
