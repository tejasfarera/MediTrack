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
            } else {
                print("Permission for local notification denied")
            }
        }
    }
    
    func scheduleNotification(dosetiming: DoseTiming) {

        let content = UNMutableNotificationContent()
        content.title = dosetiming.notificationTitle
        content.body = dosetiming.notificationBody
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 09
        dateComponents.minute = 57
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: dosetiming.notificationIdentifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    
    func cancelNotificationSchedule(doseTiming: DoseTiming) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [doseTiming.notificationIdentifier])
    }
}
