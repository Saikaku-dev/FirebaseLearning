//
//  FirebaseLearningApp.swift
//  FirebaseLearning
//
//  Created by cmStudent on 2025/04/08.
//

import SwiftUI
import Firebase

@main
struct FirebaseLearningApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            UploadDataTestView()
        }
    }
}
