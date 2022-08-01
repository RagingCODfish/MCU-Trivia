//
//  ContentView.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                VStack(spacing: 20) {
//                    VStack(spacing: 20) {
                        
                        Spacer()
                        
                        Text("MCU Trivia")
                            .ThanosTitle()                        
                        
                        Image("glove6")
                            .resizable()
                            .scaledToFit()

                        
                        Text("Can you survive the Inevitable?")
                            .foregroundColor(Color("AccentColor"))
  //                  }
                    
                    NavigationLink {
                        HowToPlayView()
                    } label: {
                        PrimaryButton(text: "How to play")
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        TriviaView(endless: false)
                    } label: {
                        PrimaryButton(text: "Short Quiz")
                    }
                    
                    Text("Your current High Score for short quiz is \(triviaManager.shorthighscore)")
                        .foregroundColor(Color("AccentColor"))
                    
                    
                    NavigationLink {
                        TriviaView(endless: true)
                    } label: {
                        PrimaryButton(text: "Endless")
                    }
                    
                    
                    Text("Your current High Score for Endless is \(triviaManager.endlesshighscore)")
                        .foregroundColor(Color("AccentColor"))
   
                }
                .padding([.top, .bottom], 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(Color("Thanos"))

            }
        }
        .navigationBarHidden(true)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
