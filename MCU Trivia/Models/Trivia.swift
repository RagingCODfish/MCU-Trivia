//
//  Trivia.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import Foundation

struct Trivia: Codable {
    var id: Int
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    
    var answers: [Answer] {
        do {
            let correct = [Answer(text: correctAnswer, isCorrect: true)]
            var incorrects = incorrectAnswers.map { answer in
                Answer(text: answer, isCorrect: false)
            }
            
            // Removes any extra possible incorrect answers
            while incorrects.count > 3 {
                incorrects.shuffle()
                incorrects.removeLast()
            }
            
            let allAnswers = incorrects + correct
            return allAnswers.shuffled()   // remove shuffled for testing
            
        }
    }
}
