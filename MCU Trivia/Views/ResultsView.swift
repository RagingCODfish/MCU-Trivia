//
//  ResultsView.swift
//  MCU Trivia (new)
//
//  Created by Zach Uptin on 29/8/2022.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        NavigationView {
            VStack {
                Image("glove6")
                    .resizable()
                    .scaledToFit()
                
                Text("You made it to the end")
                    .ThanosTitle()
                
                Text("You answered \(triviaManager.index) out of \(triviaManager.length)")
                    .ThanosTitle()
                
                Text("You scored \(triviaManager.points)")
                    .ThanosTitle()
                
                NavigationLink {
                    ContentView()
                } label: {
                    PrimaryButton(text: "Home")
                }
            } // VStack
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Thanos"))
            
        } // NavigationView
        .navigationBarHidden(true)
        .onAppear {
            print("ResultsView")
        }

    } // Body
} // ResultsView

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
            .environmentObject(TriviaManager())
    }
}
