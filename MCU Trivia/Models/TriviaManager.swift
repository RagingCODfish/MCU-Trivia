//
//  TriviaManager.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    //let webpage = "https://ragingcodfish.github.io/MarvelTrivia/"
    let webpage = "https://ragingcodfish.github.io/MCU-Trivia/"
    
    private(set) var trivia: [Trivia] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published private(set) var questionID = 0
    @Published var incorrectAnswer = 0
    @Published var points = 0
    @Published var multiplier = 0
    @AppStorage("shorthighscore") var shorthighscore: Int = 0
    @AppStorage("endlesshighscore") var endlesshighscore: Int = 0
    var endless = false
    
    
    let maxTime = 50
    @Published var timeRemaining = 50
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect() /// 0.4 makes the questions go for 20 seconds
    
    var interstial = Interstitial()
    init() {
        interstial.LoadInterstitial()
        Task.init {
            await fetchTrivia()
        }
    }
    
    func fetchTrivia() async {
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
                self.progress = 0.00
                self.reachedEnd = false
                self.incorrectAnswer = 6  // 6 for testing ---- 0 for release
                self.trivia = decodedData.shuffled() //ordered for testing
                self.length = self.trivia.count
                self.setQuestion()
                self.endless = false
                
            }
        } catch {
            print("Error fetching trivia \(error)")
        }
    }
    
    func goToNextQuestion() {
        if incorrectAnswer == 8 {
            reachedEnd = true
            gameOver()
        }
        
        if endless {
            if index + 1 < length {
                index += 1
                setQuestion()
            } else {
                reachedEnd = true
                gameOver()
            }
        } else {
            if index + 1 < 30 {
                index += 1
                setQuestion()
            } else {
                reachedEnd = true
                gameOver()
            }
        }
        
    }
    
    func setQuestion() {
        answerSelected = false
        
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
            questionID = currentTriviaQuestion.id

        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
            multiplier += 1
            points += timeRemaining * multiplier
        } else {
            incorrectAnswer += 1
            points -= 10
            multiplier = 0
            if incorrectAnswer == 7 {
                reachedEnd = true
                updateHighScore()
                self.interstial.showAd()
            }
        }
    }
    
    func updateHighScore() {
        if endless {
            if points > endlesshighscore {
                endlesshighscore = points
                UserDefaults.standard.set(endlesshighscore, forKey: "endlesshighscore")
            }
        } else {
            if points > shorthighscore {
                shorthighscore = points
                UserDefaults.standard.set(shorthighscore, forKey: "shorthighscore")
            }
        }
        
    }
    
    func decreaseTimer() {
        timeRemaining -= 1 // stops the clock for testing
    }
    
    func resetTimer() {
        timeRemaining = maxTime
    }
    
    func gameOver() {
        updateHighScore()
        //self.interstial.showAd()
    }
}
