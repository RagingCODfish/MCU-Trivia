//
//  ContentView.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text("MCU TRIVIA")
                    .ThanosTitle()
                
                Image("glove6")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                NavigationLink {
                    HowToPlayView()
                } label: {
                    PrimaryButton(text: "30 Questions")
                }

                
                NavigationLink {
                    InevitableHowToPlay()
                } label: {
                    PrimaryButton(text: "Inevitable Mode")
                }
                
                NavigationLink {
                    MovieListView()
                } label: {
                    PrimaryButton(text: "Movies and Shows")
                }
                
                Spacer()
            
            }// VStack
            .padding([.top, .bottom], 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("Thanos"))
            
            
        } //NavigationView
        .navigationBarHidden(true)
        .onAppear {
            triviaManager.reachedEnd = false
            print("ContentView")
            print(triviaManager.reachedEnd)
        }

    } //Body
} // ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TriviaManager())
    }
}
