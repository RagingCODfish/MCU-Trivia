//
//  MovieListView.swift
//  MCU Trivia (new)
//
//  Created by Zach Uptin on 31/8/2022.
//

import SafariServices
import SwiftUI

struct MovieListView: View {
    let MCUTitles: [Title] = Bundle.main.decode("Titles.json")
    
    var body: some View {
        VStack {
            Text("Marvel Cinematic Titles that are included in this quiz")
            
            List {
                ForEach(MCUTitles, id: \.self) { title in
                        Link(title.title, destination: URL(string: title.link)!)
                        .listRowSeparator(.visible)
                    
                        
                } // Foreach
                .listRowBackground(Color("Thanos"))
                .foregroundColor(.yellow)
                
            } // List
            .listStyle(.plain)
        } // VStack

        .background(Color("Thanos"))
    }
    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
            .preferredColorScheme(.dark)
    }
}
