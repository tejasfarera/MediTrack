import Foundation

final class HistoryPresenter {
    
    var doseList: [DoseModel] = []
    
    var displayableDoseList: [DisplayableDoseModel] = []
    
    init() {        
        getMedicineTimings()
    }
    
    func getMedicineTimings() {
        doseList = CoreDataManager.shared.getDoseList()
        setDisplayableDoseList()
    }
    
    func setDisplayableDoseList() {
        doseList.forEach { dose in
            let indexToInsert = displayableDoseList.firstIndex { (displayableDose) -> Bool in
                displayableDose.dateString == dose.date.mmddyyy
            }
            
            if let _indexToInsert = indexToInsert {
                displayableDoseList[_indexToInsert].doseModels.append(dose)
            } else {
                displayableDoseList.append(DisplayableDoseModel(dateString: dose.date.mmddyyy, doseModels: [dose]))
            }
        }
    }
}
