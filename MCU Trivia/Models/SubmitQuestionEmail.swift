//
//  SubmitQuestionEmail.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 1/8/2022.
//

import UIKit
import SwiftUI

struct SubmitQuestionEmail {

    let toAddress: String
    let subject: String
    let messageHeader: String
    
    var body: String {"""
        Question:
        Correct Answer:
        Incorrect Answers:

        *Seperate incorrect answers with a ','
"""
        
    }
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("""
                    This device does not support email
                    \(body)
                    """
                )
            }
        }
    }
}
