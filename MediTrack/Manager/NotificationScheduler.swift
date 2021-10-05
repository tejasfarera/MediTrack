import Foundation
import UserNotifications

class NotificationScheduler {
    static var shared = NotificationScheduler()
    
    var notificationCenter: UNUserNotificationCenter
    
    private init() {
        notificationCenter = UNUserNotificationCenter.current()
    }
    
    
    func askUserPermissionForNotifications() {
        notificationCenter.getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .notDetermined || settings.authorizationStatus == .denied) {
                self.requestForNotification()
            } else {
                print("Authorised for notifications")
            }
        }
    }
    
    @objc func requestForNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Permission for local notification granted")
                self.createNotifications()
            } else {
                print("Permission for local notification denied")
            }
        }
    }
    
    func createNotifications() {
        let identifierList = listAllNotificationRequests()
        
        /// safe checks to make notification trigger only if that notification trigger don't exist already
        
        if !identifierList.contains(DoseTiming.morning.notificationIdentifier) {
            self.scheduleNotification(dosetiming: .morning)
        }
        
        if !identifierList.contains(DoseTiming.noon.notificationIdentifier) {
            self.scheduleNotification(dosetiming: .noon)
        }
        
        if !identifierList.contains(DoseTiming.evening.notificationIdentifier) {
            self.scheduleNotification(dosetiming: .evening)
        }
    }
    
    func scheduleNotification(dosetiming: DoseTiming) {

        let content = UNMutableNotificationContent()
        content.title = dosetiming.notificationTitle
        content.body = dosetiming.notificationBody
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = dosetiming.getNotificationTimeInHours()
        dateComponents.minute = 0
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: dosetiming.notificationIdentifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    
    func cancelNotificationScheduleForToday(doseTiming: DoseTiming) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [doseTiming.notificationIdentifier])
    }
    
    func clearAllNotificationTriggers() {
        notificationCenter.getPendingNotificationRequests { requests in
            requests.forEach { (request) in
                self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [request.identifier])
            }
        }
    }
    
    func listAllNotificationRequests() -> [String] {
        var notificationIdentifierList: [String] = []
        notificationCenter.getPendingNotificationRequests {
            $0.forEach {
                notificationIdentifierList.append($0.identifier)
            }
        }
        return notificationIdentifierList
    }
    
    ///NOTE: This method isn't working, can't create trigger for tomorrow date, it creates trigger for current date
    func scheduleNotificationForTomorrow(dosetiming: DoseTiming) {
        
        let content = UNMutableNotificationContent()
        content.title = dosetiming.notificationTitle
        content.body = dosetiming.notificationBody
        content.sound = UNNotificationSound.default
        
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        let userCalendar = Calendar.current
        var dateComponents = userCalendar.dateComponents([.hour, .minute], from: tomorrow!)
        
        dateComponents.hour = dosetiming.getNotificationTimeInHours()
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
//        print(trigger.nextTriggerDate())
        
        let request = UNNotificationRequest(
            identifier: dosetiming.notificationIdentifier, content: content, trigger: trigger
        )
        
        notificationCenter.add(request)
    }
    
    
}
