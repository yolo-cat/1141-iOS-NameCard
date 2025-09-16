//
//  NameCardApp.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI
import SwiftData

@main
struct NameCardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [StoredContact.self,
            ContactCategory.self]
        )
    }
}
