//
//  AnswerRow.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import SwiftUI

struct AnswerRow: View {
    
    @EnvironmentObject var triviaManager: TriviaManager
    var answer: Answer
    @State private var isSelected = false
    
    var gold = Color("AccentColor")
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: answer.isCorrect ? "checkmark" : "x.circle.fill")
                    .foregroundColor(answer.isCorrect ? gold : red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(triviaManager.answerSelected ? (isSelected ? Color("AmericanBlue") : .gray) : Color("AmericanBlue"))
        .background(Color("LightThanos"))
        .cornerRadius(10)
        .shadow(color:  isSelected ? (answer.isCorrect ? gold : red) : .gray, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !triviaManager.answerSelected {
                isSelected = true
                triviaManager.selectAnswer(answer: answer)
            }
            
        }
    }
}

struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRow(answer: Answer(text: "Single", isCorrect: true))
            .environmentObject(TriviaManager())
    }
}
