//
//  MCU_TriviaApp.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 13/7/2022.
//

import SwiftUI

@main
struct MCU_TriviaApp: App {
    @StateObject var triviaManager = TriviaManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(triviaManager)
        }
    }
}
