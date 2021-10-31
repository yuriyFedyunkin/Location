//
//  UserNotificationService.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 31.10.2021.
//

import UserNotifications

protocol UserNotificationService {
    func sendNotificatioRequest(
        content: UNNotificationContent,
        trigger: UNNotificationTrigger
    )
}

final class UserNotificationServiceImpl: UserNotificationService {
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    func sendNotificatioRequest(
        content: UNNotificationContent,
        trigger: UNNotificationTrigger
    ) {
        
        userNotificationCenter.requestAuthorization(
            options: [.alert, .badge, .sound]) { [weak self] granted, error in
                guard granted else { return }
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                
                self?.userNotificationCenter.add(request) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
    }
}
