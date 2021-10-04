import Foundation

struct DisplayableDoseModel {
    let dateString: String
    var doseModels: [DoseModel]
    
    func getDoseTimings() -> [DoseTiming] {
        var doseTimings: [DoseTiming] = []
        doseTimings.forEach { doseTimings.append($0) }
        return doseTimings
    }
}
