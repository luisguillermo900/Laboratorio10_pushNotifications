//
//  ContentView.swift
//  PushNotifications
//
//  Created by epismac on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var notificationMessage = "Esperando notificación..."

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text(notificationMessage)
                .font(.headline)
                .padding()
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            notificationMessage = "Esperando notificación..."
        }
    }
}

