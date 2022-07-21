//
//  HowToPlayView.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 19/7/2022.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        VStack {
            Text("How To Play")
            
            Spacer()
                
            Text("Answer questions quickly to score more points, answering multiple questions correctly in a row will earn you a multiper. Incorrect answers will see you lose points and reset your multipler. An incorrect answer will also allow Thanos to collect a Stone, once he has all 6 the game is over! Once you have answered 30 questions Thanos will collect the all the stones and will snap you into game over once you give an incorrect answer!")
            
            Spacer()
            
            Text("This is a quiz based solely on the Marvel Cinematic Universe!")
            
            Spacer()
            
        }
        .foregroundColor(Color("AccentColor"))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Thanos"))
    }
    
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
