import Foundation
import UIKit

enum StoryBoardName: String {
    case Home
    case History
    
    func getInitialViewController() -> UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: self.rawValue + "VC")
    }
}

struct Constants {
    static let secondsInMinute: Int = 60
    static let secondsInHour: Int = 60 * 60
    static let secondsInDay: Int = 60 * 60 * 24
}

struct Keys {
    static let doseTiming = "doseTiming"
    static let date = "date"
    static let dateString = "dateString"
    static let points = "points"
}
