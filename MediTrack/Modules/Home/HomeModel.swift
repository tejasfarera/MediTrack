import Foundation
import UIKit.UIColor

struct DoseModel: Equatable {
    let doseTiming: DoseTiming
    let date: Date
    
    static func == (lhs: DoseModel, rhs: DoseModel) -> Bool {
        return lhs.date.mmddyyy == rhs.date.mmddyyy
    }
}

struct DisplayableDoseModel {
    let dateString: String
    var doseModels: [DoseModel]
    
    func getDoseTimings() -> [DoseTiming] {
        var doseTimings: [DoseTiming] = []
        doseTimings.forEach { doseTimings.append($0) }
        return doseTimings
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
    
    static func getColor(score: Int) -> UIColor {
        if score >= 0 && score <= 40 {
            return UIColor.red
        }
        
        if score > 40 && score <= 70 {
            return UIColor.orange
        }
        
        if score > 70 {
            return UIColor.green
        }
        
        return UIColor.red
    }
    
    static func getScore(timingsInString: [DoseModel]) -> Int {
        var score: Int = 0
        
        timingsInString.forEach { score += $0.doseTiming.points }
        
        return score
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


