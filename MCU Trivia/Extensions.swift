//
//  Extensions.swift
//  MarvelTrivia
//
//  Created by Zach Uptin on 12/7/2022.
//

import Foundation
import SwiftUI

extension Text {
    func ThanosTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
