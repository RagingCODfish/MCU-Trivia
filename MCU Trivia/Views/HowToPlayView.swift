//
//  HowToPlayView.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 19/7/2022.
//

import SwiftUI

struct HowToPlayView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    var body: some View {
        NavigationView {
            VStack {
                Text("Short")
                    .ThanosTitle()
                
                Text("Just a warm up")
                    .foregroundColor(.yellow)
                
                NavigationLink {
                    QuestionView()
                }label: {
                    PrimaryButton(text: "Assemble")
                }
                
                NavigationLink {
                    ContentView()
                } label: {
                    PrimaryButton(text: "Home")
                }

            } // VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Thanos"))
        } // NavigationView
        .navigationBarHidden(true)
        .onAppear {
            print("HowToPlayView")
            Task.init {
                await triviaManager.fetchTrivia(endless: false)
            }
        }
    } // Body
} // HowToPlayView

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
            .environmentObject(TriviaManager())
    }
}
