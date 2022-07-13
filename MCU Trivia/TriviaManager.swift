//
//  TriviaManager.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    let webpage = "https://ragingcodfish.github.io/MarvelTrivia/"
    
    private(set) var trivia: [Trivia] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    @Published private(set) var incorrectAnswer = 0
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
            //print("response", response, "data", String(decoding: data, as: UTF8.self))
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            
            let decodedData = try decoder.decode([Trivia].self, from: data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                self.incorrectAnswer = 0
                
                self.trivia = decodedData//.shuffled() ordered for testing
                self.length = self.trivia.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia \(error)")
        }
    }
    
    func goToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat((Double(index) + 1) / Double(length) * 350)
        
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        } else {
            incorrectAnswer += 1
            if incorrectAnswer == 7 {
                reachedEnd = true
                //self.interstial.showAd() /// Calls the ad, need to add this to button
                
                
            }
        }
    }
}

import Foundation
import GoogleMobileAds
import UIKit

let test = "ca-app-pub-3940256099942544/4411468910"
let myAd = "ca-app-pub-4765977749695147/5929721516"
    
final class Interstitial: NSObject, GADFullScreenContentDelegate {
    var interstitial:GADInterstitialAd?
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        self.interstitial = nil
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: request) { interstialAd, error in  /// change test to myAd for release
            if error == nil {
                if let ad = interstialAd {
                    // we do have ad
                    self.interstitial = ad
                    self.interstitial?.fullScreenContentDelegate = self
                }
            } else {
                print("Error == \(error) and localized info == \(error?.localizedDescription)")
            }
        }
    }
    
    func showAd(){
        
        if self.interstitial != nil {
            guard let root = UIApplication.shared.windows.first?.rootViewController else {return}
            self.interstitial?.present(fromRootViewController: root)
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("ad fail to present as full screen")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        LoadInterstitial()
    }
}

