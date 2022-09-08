//
//  QuestionView.swift
//  MCU Trivia (new)
//
//  Created by Zach Uptin on 30/8/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    @State private var timeRemaining = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if triviaManager.reachedEnd {
            ResultsView()
        } else {
            VStack {
                Image("glove\(triviaManager.incorrectAnswer)")
                    .resizable()
                    .scaledToFit()
                
                VStack {
                    Text("Trivia Question \(triviaManager.questionID) for testing") // for testing
                        .foregroundColor(.yellow)
                } // VStack
                Text(triviaManager.question)
                    .bold()
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .frame(width: 350, height: 100)
                    .padding()
                    .foregroundColor(Color("AccentColor"))
                
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                }
                .padding(.horizontal)
                
                Section {
                    if triviaManager.answerSelected == true {
                        Button {
                            triviaManager.goToNextQuestion()
                        } label: {
                            PrimaryButton(text: "Next")
                        }
                    } else {
                        Image(systemName: "\(triviaManager.timeRemaining).circle")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                            .onReceive(triviaManager.timer) { _ in
                                if triviaManager.timeRemaining == 0 {
                                    withAnimation() {
                                        triviaManager.incorrectAnswer += 1
                                        triviaManager.goToNextQuestion()
                                    }
                                } else {
                                    withAnimation() {
                                        triviaManager.decreseTimer()
                                    }
                                }
                            }
                    } // else
                }
                .frame(height: 30)
                .padding()
                
            } // VStack

            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Thanos"))
            .navigationBarHidden(true)
            .onAppear {
                print("QuestionView")
            }
        } 
    } // Body
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(TriviaManager())
    }
}
