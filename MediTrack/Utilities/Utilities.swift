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
    static let secondsInMinute: TimeInterval = 60
    static let secondsInHour: TimeInterval = 60 * 60
    static let secondsInDay: TimeInterval = 60 * 60 * 24
}

struct Keys {
    static let doseTiming = "doseTiming"
    static let date = "date"
    static let points = "points"
}

enum CustomDateFormatter: String {
    
    case mm_dd_yyy = "dd/mm/yyyy"
    
    
    func formatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
}

