//
//  SubmitQuestionView.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 13/7/2022.
//

import SwiftUI

struct SubmitQuestionView: View {
    
    @State private var question = ""
    @State private var correctAnswer = ""
    @State private var incorrectAnswer1 = ""
    @State private var incorrectAnswer2 = ""
    @State private var incorrectAnswer3 = ""
    
    var body: some View {
        VStack {
            Text("Got a question you want to add?")
            
            Group {
                TextField("Enter the question", text: $question)
                TextField("Enter the question", text: $correctAnswer)
                TextField("Enter the question", text: $incorrectAnswer1)
                TextField("Enter the question", text: $incorrectAnswer2)
                TextField("Enter the question", text: $incorrectAnswer3)
            }
            
            
            // need to fix textfield color
            
            Button {
                // code to actually submit the question
                print("Submit question to an email address hopefully")
            } label: {
                PrimaryButton(text: "Submit")
            }
            
            
        }
        .foregroundColor(Color("AccentColor"))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Thanos"))
    }
}

struct SubmitQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitQuestionView()
    }
}
