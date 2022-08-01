//
//  SubmitQuestionView.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 13/7/2022.
//

import SwiftUI

struct SubmitQuestionView: View {
    @Environment(\.openURL) var openURL
    private var email = SubmitQuestionEmail(toAddress: "mcutriviaapp@gmail.com", subject: "New Question", messageHeader: "Please add a question, a correct answer and a minimum of 3 incorrect answers. You can add more incorrect answers if you like.")


    
    var body: some View {
        VStack {
            Text("Got a question you want to add?")
            
            
            Group {
//                TextField("Enter the question", text: $sq.question)
//                TextField("Enter the correct answer", text: sq.$correctAnswer)
//                TextField("Enter a wrong answer", text: sq.$incorrectAnswer1)
//                TextField("Enter a wrong answer", text: sq.$incorrectAnswer2)
//                TextField("Enter a wrong answer", text: sq.$incorrectAnswer3)
            }  
            // need to fix textfield color
            
            Button {
                email.send(openURL: openURL)
                //print("Submit question to an email address hopefully")
            } label: {
                PrimaryButton(text: "Submit")
            }
            
            
        }
        .foregroundColor(Color("AccentColor"))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Thanos"))
        .statusBar(hidden: true)
    }
    
    
}

struct SubmitQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitQuestionView()
    }
}
