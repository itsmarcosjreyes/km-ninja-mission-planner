//
//  NinjaMissionPlannerApp.swift
//  NinjaMissionPlanner
//
//  Created by Marcos J Reyes at Kinetic Matrix
//
import SwiftUI
import SwiftData

@main
struct NinjaMissionPlannerApp: App {
    @StateObject private var authVM = AuthorizationVM()
    @StateObject private var missionsVM = MissionsVM()

    var body: some Scene {
        WindowGroup {
            if authVM.isSignedIn {
                MissionsScreen()
                    .environmentObject(authVM)
                    .environmentObject(missionsVM)
            } else {
                OnboardingView()
                    .environmentObject(authVM)
                    .environmentObject(missionsVM)
            }
        }
    }
}
