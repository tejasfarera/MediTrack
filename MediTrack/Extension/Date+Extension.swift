import Foundation

extension Date {
    
    var mmddyyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var getLocalDayTimeStamp: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let hours = Int(dateFormatter.string(from: self)) ?? 0
        
        dateFormatter.dateFormat = "mm"
        let minutes = Int(dateFormatter.string(from: self)) ?? 0
        
        dateFormatter.dateFormat = "ss"
        let seconds = Int(dateFormatter.string(from: self)) ?? 0
        
        return (hours * Constants.secondsInHour) + (minutes * Constants.secondsInMinute) + seconds
    }
}
