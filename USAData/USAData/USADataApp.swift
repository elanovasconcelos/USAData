//
//  USADataApp.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

@main
struct USADataApp: App {
    
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            MainFactory.makeRootView(coordinator: coordinator)
        }
    }
}
