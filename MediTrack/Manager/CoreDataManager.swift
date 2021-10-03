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
    
    @discardableResult func saveDose(doseModel: DoseModel) -> Bool {
        
        guard let _context = self.context else {
            print("Can't find context for core data")
            return false
        }
        
        let dose = NSEntityDescription.entity(forEntityName: "Dose", in: _context)
        let newDose = NSManagedObject(entity: dose!, insertInto: context)
        
        newDose.setValue(doseModel.doseTiming.rawValue, forKey: Keys.doseTiming)
        newDose.setValue(doseModel.date, forKey: Keys.date)
        
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
    
    func clearData() {
        guard let _context = self.context else {
            print("Can't find context for core data")
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dose")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try _context.fetch(fetchRequest)
            for managedObject in results {
                if let _managedObject = managedObject as? NSManagedObject {
                    _context.delete(_managedObject)
                }
            }
            try _context.save()
        } catch let error as NSError {
            print("Delete all my data in Dose error : \(error) \(error.userInfo)")
        }
    }
}
