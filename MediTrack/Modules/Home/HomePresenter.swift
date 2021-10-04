import Foundation
import UIKit.UIColor

protocol HomePresenterDelegate {
    func showHistoryScreen()
    func setUpUI()
    func setData()
}

final class HomePresenter {
    
    var isCurrentDoseTaken: Bool
    
    var todaysDoses: [DoseModel]
    
    var homeButtonAction: HomeButtonAction
    
    private var delegate: HomePresenterDelegate?
    
    init(delegate: HomePresenterDelegate) {
        self.delegate = delegate
        isCurrentDoseTaken = CoreDataManager.shared.isCurrentDoseTaken()
        homeButtonAction = HomeButtonAction(isDoseTaken: isCurrentDoseTaken)
        todaysDoses = CoreDataManager.shared.getTodaysDoses()
        initialiseUI()
    }
    
    func initialiseUI() {
        delegate?.setUpUI()
    }
    
    func onViewAppear() {
        delegate?.setData()
    }
    
    @discardableResult func resetAndCheckCurrentDoseTaken() -> Bool {
        self.isCurrentDoseTaken = CoreDataManager.shared.isCurrentDoseTaken()
        self.homeButtonAction = HomeButtonAction(isDoseTaken: isCurrentDoseTaken)
        self.todaysDoses = CoreDataManager.shared.getTodaysDoses()
        self.delegate?.setData()
        return isCurrentDoseTaken
    }
    
    func getScore() -> String {
        return DoseTiming.getScore(timingsInString: todaysDoses).description
    }
    
    func getScoreColor() -> UIColor {
        return DoseTiming.getColor(score: DoseTiming.getScore(timingsInString: todaysDoses))
    }
    
    func getWishingText() -> String {
        return DoseTiming.getDoseTiming().getwishingText(isDoseTaken: isCurrentDoseTaken)
    }
    
    func getButtonText() -> String {
        return homeButtonAction.buttonTitle
    }
    
    func onPressButton() {
//        CoreDataManager.shared.saveDose(doseModel: DoseModel(doseTiming: .morning, date: Date().addingTimeInterval(TimeInterval(Constants.secondsInHour * 13))))
        
        switch homeButtonAction {
        case .showHistory:
            delegate?.showHistoryScreen()
        case .takeMedicine:
            if CoreDataManager.shared
                .saveDose(doseModel: DoseModel(doseTiming: DoseTiming.getDoseTiming(), date: Date())) {
                resetAndCheckCurrentDoseTaken()
            }
        }
    }
}
