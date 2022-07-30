//
//  HowToPlayView.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 19/7/2022.
//

import SwiftUI

struct HowToPlayView: View {
    @AppStorage("highscore") var highscore: Int = 0
    
    var body: some View {
        VStack {
            Text("How To Play")
            
            Spacer()
                
            Text("")
            
            Spacer()
            
            Text("This is a quiz based solely on the Marvel Cinematic Universe!")
            
            Button {
                updateHighScore()
            } label: {
                PrimaryButton(text: "Reset High Score")
            }
            
            Spacer()
            
        }
        .foregroundColor(Color("AccentColor"))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Thanos"))
    }
    
    func updateHighScore() {
            highscore = 0
            UserDefaults.standard.set(highscore, forKey: "highscore")
        }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
