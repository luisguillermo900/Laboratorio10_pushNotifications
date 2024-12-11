//
//  PushNotificationsApp.swift
//  PushNotifications
//
//  Created by epismac on 10/12/24.
//

import SwiftUI

@main
struct PushNotificationsApp: App {
    
    init() {
        PushNotificationManager.shared.requestPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    PushNotificationManager.shared.requestPermission()
                }
        }
    }
}
