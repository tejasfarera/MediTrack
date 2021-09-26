import Foundation
import UIKit

extension UIViewController {
    func showHistory() {
        guard let historyVC = StoryBoardName.History.getInitialViewController() as? HistoryVC else {
            debugPrint("Can't find HistoryVC")
            return
        }
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
}
