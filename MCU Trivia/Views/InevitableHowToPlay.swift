//
//  InevitableHowToPlay.swift
//  MCU Trivia (new)
//
//  Created by Zach Uptin on 30/8/2022.
//

import SwiftUI

struct InevitableHowToPlay: View {
    @EnvironmentObject var triviaManager: TriviaManager
    var body: some View {
        NavigationView {
            VStack {
                Text("Inevitable")
                    .ThanosTitle()
                
                Text("Questions keep coming.. can you answer them all? Each wrong answer Thanos will collect an Infinity Stone. If he collects them all he will snap his fingers and the game is over!")
                    .fontWeight(.light)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.yellow)
                
                
                NavigationLink {
                    QuestionView()
                } label: {
                    PrimaryButton(text: "I Can Do This All Day")
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
            print("InevitableHowToPlayView")
            Task.init {
                await triviaManager.fetchTrivia(endless: true)
            }
        }
    } // Body
} // HowToPlayView

struct InevitableHowToPlay_Previews: PreviewProvider {
    static var previews: some View {
        InevitableHowToPlay()
            .environmentObject(TriviaManager())
    }
}
