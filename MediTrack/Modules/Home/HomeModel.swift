import Foundation
import UIKit.UIColor

struct DoseModel: Equatable {
    let doseTiming: DoseTiming
    let date: Date
    
    static func == (lhs: DoseModel, rhs: DoseModel) -> Bool {
        return lhs.date.mmddyyy == rhs.date.mmddyyy
    }
}


enum DoseTiming: String {
    /// 12:00:00 AM to 05:59:59 AM idle time
    case idle
    /// 06:00:00 AM to 11:59:59 AM morning time
    case morning
    /// 12:00:00 PM to 04:59:59 PM noon time
    case noon
    /// 05:00:00 PM to 11:59:59 PM evening time
    case evening
    
    var points: Int {
        switch self {
        case .idle:
            return 0
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
    
    func getStartTime() -> Int {
        switch self {
        case .idle:
            /// Start time will be 12:00 am
            return Constants.secondsInHour * 0
        case .morning:
            /// Start time will be 6:00 am
            return Constants.secondsInHour * 6
        case .noon:
            /// Start time will be 12:00 pm
            return Constants.secondsInHour * 12
        case .evening:
            /// Start time will be 05:00 pm
            return Constants.secondsInHour * 17
        }
    }
    
    func getEndTime() -> Int {
        switch self {
        case .idle:
            /// end time will be 05:59:59 am
            return (Constants.secondsInHour * 5) + (60 * 59) + (59)
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
    
    static func getDoseTiming() -> Self {
        let dayTimeStamp = Date().getLocalDayTimeStamp
        
        if dayTimeStamp >= DoseTiming.morning.getStartTime() && dayTimeStamp <= DoseTiming.morning.getEndTime() {
            return .morning
        }
        
        if dayTimeStamp >= DoseTiming.noon.getStartTime() && dayTimeStamp <= DoseTiming.noon.getEndTime() {
            return .noon
        }
        
        if dayTimeStamp >= DoseTiming.evening.getStartTime() && dayTimeStamp <= DoseTiming.evening.getEndTime() {
            return .evening
        }
        
        return .idle
    }
    
    func getwishingText(isDoseTaken: Bool) -> String {
        switch self {
        case .idle:
            return "Welcome"
        case .morning:
            return isDoseTaken ? "Morning dose taken" : "Good Morning"
        case .noon:
            return isDoseTaken ? "Afternoon dose taken" : "Good Afternoon"
        case .evening:
            return isDoseTaken ? "Evening dose taken" : "Good Evening"
        }
    }
}

enum HomeButtonAction {
    case showHistory
    case takeMedicine
    
    init(isDoseTaken: Bool) {
        switch DoseTiming.getDoseTiming() {
        case .idle:
            self = .showHistory
        case .morning, .noon, .evening:
            self = isDoseTaken ? .showHistory : .takeMedicine
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .showHistory:
            return "Show History"
        case .takeMedicine:
            return "Take Medicine"
        }
    }
}
