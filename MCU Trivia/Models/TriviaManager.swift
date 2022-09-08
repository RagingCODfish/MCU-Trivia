//
//  TriviaManager.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    let webpage = "https://ragingcodfish.github.io/MCU-Trivia/"
    
    var reachedEnd = false
    
    private(set) var trivia: [Trivia] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var answerSelected = false
    @Published private(set) var question: String = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published private(set) var questionID = 0
    @Published var incorrectAnswer = 0
    @Published var points = 0
    @Published var multiplier = 0
    
    @AppStorage("shorthighscore") var shorthighscore: Int = 0
    @AppStorage("endlesshighscore") var endlesshighscore: Int = 0
    
    let maxTime = 50
    @Published var timeRemaining = 50
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect() /// 0.4 makes the questions go for 20 seconds
    
    var interstial = Interstitial()
    init() {
        interstial.LoadInterstitial()
    }
    
    func fetchTrivia(endless: Bool) async {
        guard let url = URL(string: webpage) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([Trivia].self, from: data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.0
                self.reachedEnd = false
                self.incorrectAnswer = 0
                self.trivia = decodedData//.shuffled()
                if endless {
                    self.length = self.trivia.count
                } else {
                    self.length = 30
                }
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia \(error)")
        }
    }
    
    func goToNextQuestion() {
        if incorrectAnswer > 6 {
            gameOver()
        } else {
            index += 1
            setQuestion()
        }
        if index + 1 > length {
            gameOver()
        }
    }
    
    func setQuestion() {
        answerSelected = false
        resetTimer()
        
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.question
            answerChoices = currentTriviaQuestion.answers
            questionID = currentTriviaQuestion.id
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
            points += timeRemaining
        } else {
            incorrectAnswer += 1
        }
    }
    
    func decreseTimer() {
        timeRemaining -= 1
    }
    
    func resetTimer() {
        timeRemaining = maxTime
    }
    
    func gameOver() {
        reachedEnd = true
        points = points * score
        updateHighScore()
//        self.interstial.showAd()
        
        
        // show ad func call
        
    }
    
    func updateHighScore() {
        // code to update scores to memory
    }
    
    func resetHighScore() {
        // code to reset userdefaults scores
    }
    
    
    
}
