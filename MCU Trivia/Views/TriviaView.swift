//
//  TriviaView.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    var endless: Bool
    
    var body: some View {
        if triviaManager.reachedEnd {
            VStack(spacing: 10) {
                
                Image("glove\(triviaManager.incorrectAnswer)")
                    .resizable()
                    .scaledToFit()
                
                if triviaManager.incorrectAnswer < 6 {
                    Text("You saved the Universe")
                        .ThanosTitle()
                    
                } else {
                    Text("You Turned To Dust!")
                        .ThanosTitle()
                    
                }
                
                Text("You answered \(triviaManager.score) out of \(triviaManager.index + 1) correctly")
                Text("You scored: \(triviaManager.points)")
                Text("Your Highest Score is \(triviaManager.highscore)")
                
                
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
            .onAppear { triviaManager.endless = triviaManager.endless }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Thanos"))
        } else {
            withAnimation(){
                QuestionView()

                    
            }
        }
    }
}


struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView(endless: true)

    }
}
