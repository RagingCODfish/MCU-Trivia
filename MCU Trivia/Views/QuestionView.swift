//
//  QuestionView.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import SwiftUI

struct QuestionView: View {
    
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        VStack {
            VStack {
                Text("MCU Trivia")
                    .ThanosTitle()
                Text("Question number \(triviaManager.index + 1)") // for testing
                
                Image("glove\(triviaManager.incorrectAnswer)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
            
            VStack {
                Text(triviaManager.question)
                    .bold()
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 150)
                    .foregroundColor(Color("AccentColor"))
                
                
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(triviaManager)
                }
            }
            
            Button {
                triviaManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: triviaManager.answerSelected ? Color("AccentColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!triviaManager.answerSelected)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Thanos"))
        .navigationBarHidden(true)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(TriviaManager())
    }
}
