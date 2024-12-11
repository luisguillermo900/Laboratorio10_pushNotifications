//
//  PushNotificationManager.swift
//  PushNotifications
//
//  Created by epismac on 10/12/24.
//

import Foundation
import UserNotifications
import UIKit

class PushNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = PushNotificationManager()
    
    func requestPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                self.registerForPushNotifications()
            } else {
                print("Permission not granted: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    private func registerForPushNotifications() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func handlePushNotification(_ userInfo: [AnyHashable: Any]) {
        // Aquí se puede manejar las notificaciones cuando la app está en primer plano
        if let aps = userInfo["aps"] as? [String: AnyObject] {
            print("Push Notification Received: \(aps)")
        }
    }
    
    // Este método se llama cuando la notificación es recibida en segundo plano o mientras la app está cerrada.
    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {
       
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(tokenString)")
    }
    
    func didFailToRegisterForRemoteNotificationsWithError(error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    // Este método se llama cuando la app recibe una notificación mientras está en primer plano.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    // Manejo de notificación cuando la app está en segundo plano o cerrada.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        handlePushNotification(userInfo)
        completionHandler()
    }
}
