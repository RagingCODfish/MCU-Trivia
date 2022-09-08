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
                
                Text("Can you answer enough questions to make it to end?")
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
