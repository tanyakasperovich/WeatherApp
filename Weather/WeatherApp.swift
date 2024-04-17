//
//  WeatherApp.swift
//  Weather
//
//  Created by Татьяна Касперович on 27.08.23.
//

import SwiftUI

@main
struct WeatherApp: App {
    // MARK: - PROPERTIEW
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @StateObject private var viewModel = WeatherViewModel()
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
                    .environmentObject(viewModel)
            } else {
                ContentView()
                    .environmentObject(viewModel)
                }
        }
    }
}
