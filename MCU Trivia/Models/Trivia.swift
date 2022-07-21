//
//  Trivia.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import Foundation

struct Trivia: Decodable {
    var id: Int
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    
    var formattedQuestion: AttributedString {
        do {
            return try AttributedString(markdown: question)
        } catch {
            print("Error setting formattedQuestion: \(error)")
            return ""
        }
    }
    
    var answers: [Answer] {
        do {
            let correct = [Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
            var incorrects = try incorrectAnswers.map { answer in
                Answer(text: try AttributedString(markdown: answer), isCorrect: false)
            }

            // Removes any extra possible incorrect answers
            while incorrects.count > 3 {
                incorrects.shuffle()
                incorrects.removeLast()
            }
            
            let allAnswers = incorrects + correct
            
            return allAnswers.shuffled()
            
        } catch {
            print("Error setting answers: \(error)")
            return []
        }
    }
}
