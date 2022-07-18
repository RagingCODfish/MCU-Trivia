//
//  TriviaView.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import SwiftUI
//ptea.sima@gmail.com
struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        if triviaManager.reachedEnd {
            VStack(spacing: 20) {
                Text("You Turned To Dust!")
                    .ThanosTitle()
                Image("glove6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    
                Text("You answered \(triviaManager.score) out of \(triviaManager.length) correctly!")
                
                Text("Support the Developer who will gather the Infinity Stones and Snap you back!")
                    .ThanosTitle()
                
                Button {
                    Task.init {
                        await triviaManager.fetchTrivia()
                    }
                } label: {
                    PrimaryButton(text: "Play again!")
                }
                
                NavigationLink {
                    SubmitQuestionView()
                } label: {
                    PrimaryButton(text: "Submit a Question")
                }
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Thanos"))
        } else {
            QuestionView()
                .environmentObject(triviaManager)
        }
            
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}
