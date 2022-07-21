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
            VStack(alignment: .leading) {
                Image("glove\(triviaManager.incorrectAnswer)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
            }
            
            // for testing
//            Text("\(triviaManager.incorrectAnswer)")
//            Text("\(triviaManager.points)")
//            Text("\(triviaManager.multiplier)")
            
            VStack {
                Text(triviaManager.question)
                    .bold()
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .frame(width: 350, height: 100)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(Color("AccentColor"))
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(triviaManager)
                }
                .padding(.horizontal)
            }
            
            VStack {
                if triviaManager.answerSelected == true {
                    Button {
                        withAnimation(){
                            triviaManager.goToNextQuestion()
                            triviaManager.resetTimer()
                        }
                    } label: {
                        PrimaryButton(text: "Next", background: Color("AccentColor"))
                    }
                } else {
                    Image(systemName: "\(triviaManager.timeRemaining).circle")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .onReceive(triviaManager.timer) { _ in
                            if triviaManager.timeRemaining == 0 {
                                withAnimation(){
                                    triviaManager.incorrectAnswer += 1
                                    triviaManager.goToNextQuestion()
                                    triviaManager.resetTimer()
                                    triviaManager.multiplier = 0
                                    
                                }
                            } else {
                                withAnimation() {
                                    triviaManager.decreaseTimer()
                                    
                                }
                            }
                        }
                }
            }
            .frame(height: 30)
            .padding()
        }
        
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
