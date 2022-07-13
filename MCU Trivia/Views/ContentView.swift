//
//  ContentView.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("MCU Trivia")
                        .ThanosTitle()
                    
                    Image("glove6")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    Text("Can you survive the Inevitable?")
                        .foregroundColor(Color("AccentColor"))
                }
                
                NavigationLink {
                    TriviaView()
                        .environmentObject(triviaManager)
                } label: {
                    PrimaryButton(text: "Assemble")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("Thanos"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
