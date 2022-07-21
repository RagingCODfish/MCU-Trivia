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
                if triviaManager.incorrectAnswer < 6 {
                    Text("You saved the Universe")
                    
                } else {
                    Text("You Turned To Dust!")
                    
                }
                
                Image("glove7")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text("You answered \(triviaManager.score) out of \(triviaManager.index + 1)")
                
                Text("You scored: \(triviaManager.points)")
                Text("Your Highest Score is \(triviaManager.highscore)")
                
                Text("Support the Developer who will gather the Infinity Stones and Snap you back!")
                    .ThanosTitle()
                
                Button {
                    Task.init {
                        await triviaManager.fetchTrivia()
                    }
                } label: {
                    PrimaryButton(text: "Play again!")
                }
                .navigationBarHidden(true)
                
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
            withAnimation(){
                QuestionView()
                    .environmentObject(triviaManager)
            }
        }
        
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}
