import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    private var appDelegate: AppDelegate?
    private var context: NSManagedObjectContext?
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.context = appDelegate?.persistentContainer.viewContext
    }
    
    func saveDose(doseModel: DoseModel) -> Bool {
        
        guard let _context = self.context else {
            print("Can't find context for core data")
            return false
        }
        
        let dose = NSEntityDescription.entity(forEntityName: "Dose", in: _context)
        let newDose = NSManagedObject(entity: dose!, insertInto: context)
        
        newDose.setValue(doseModel.doseTiming.rawValue, forKey: Keys.doseTiming)
        newDose.setValue(doseModel.date, forKey: Keys.date)
        newDose.setValue(doseModel.doseTiming.points, forKey: Keys.points)
        
        do {
           try _context.save()
          } catch {
           print("Failed saving")
            return false
        }
        
        return true
    }
    
    func getDoseList() -> [DoseModel] {
        
        var doseModel: [DoseModel] = []
        
        guard let _context = self.context else {
            print("Can't find context for core data")
            return doseModel
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Dose")
        request.returnsObjectsAsFaults = false
        
        let resultSortingParam = NSSortDescriptor(key: Keys.date, ascending: true)
        request.sortDescriptors = [resultSortingParam]
        
        do {
            let result = try _context.fetch(request)
            
            result.forEach { (dose) in
                
                if let _dose = dose as? NSManagedObject,
                   let time = _dose.value(forKey: Keys.doseTiming) as? String,
                   let date = _dose.value(forKey: Keys.date) as? Date {
                    
                    doseModel.append(
                        DoseModel(doseTiming: DoseTiming(rawValue: time) ?? .morning, date: date)
                    )
                }
            }
            
        } catch {
            print("Failed")
        }
        
        return doseModel
    }
    
    /// Used to calculate whether user has taken medicine for current timing
    func isCurrentDoseTaken() {
        getDoseList().forEach { doseModel in
 
        }
    }
}


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


enum CustomDateFormatter: String {
    
    case mm_dd_yyy = "dd/mm/yyyy"
    
    
    func formatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
}

extension Date {
    
    var mmddyyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
}


class AppEnvironment {
    
    
    
}
