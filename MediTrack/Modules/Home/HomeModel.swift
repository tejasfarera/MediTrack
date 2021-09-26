import Foundation
import UIKit.UIColor

struct DoseModel {
    let doseTiming: DoseTiming
    let date: Date
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

enum DoseTiming: String {
    case morning
    case noon
    case evening
    
    var points: Int {
        switch self {
        case .morning, .noon:
            return 30
        case .evening:
            return 40
        }
    }
    
    func getStartTime() -> TimeInterval {
        switch self {
        case .morning:
            /// Start time will be 6:00 am so calculated 6 hours after a day
            return Constants.secondsInHour * 6
        case .noon:
            return Constants.secondsInHour * 12
        case .evening:
            return Constants.secondsInHour * 17
        }
    }
    
    func getEndTime() -> TimeInterval {
        switch self {
        case .morning:
            /// end time will be 11:59:59 am
            return (Constants.secondsInHour * 11) + (60 * 59) + (59)
        case .noon:
            /// end time will be 04:59:59 pm
            return (Constants.secondsInHour * 16) + (60 * 59) + (59)
        case .evening:
            /// end time will be 11:59:59 pm
            return (Constants.secondsInHour * 23) + (60 * 59) + (59)
        }
    }
}


