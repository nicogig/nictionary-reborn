//
//  SearchCard.swift
//  Nictionary
//
//  Created by Nicola Gigante on 12/02/2022.
//

import SwiftUI
import AVFoundation
import PureSwiftUI
import PureSwiftUITools
import PureSwiftUIDesign

struct SearchCard: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State var search: String = ""
    @State var editing_state: String = "None"
    @Binding var lookUp: Bool
    @EnvironmentObject var modelData: ModelData
    
    @State var isShowingWordCard: Bool = false
    @State var wordChosen: Word
    
    var searchResults: [Word] {
            if search.isEmpty {
                return modelData.words
            } else {
                return modelData.words.filter { $0.name.lowercased().contains(search.lowercased()) }
            }
        }
    
    var body: some View {
        if isShowingWordCard {
            RandomCardView(
                randomCard: $isShowingWordCard,
                word: self.wordChosen,
                sectionName: "Word"
            )
        } else {
        GeometryReader { geometry in
        VStack {
            StatusBar(geometry: geometry)
            AppBar(lookUp: $lookUp, sectionName: "Look Up")
            SearchView(search: $search, no_right_padding: true, editing_state: $editing_state)
            Spacer()
            List {
                ForEach (searchResults) { word in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(word.name.uppercased())
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Text(word.phon)
                                .lineLimit(1)
                            Text(word.def)
                                .lineLimit(1)
                        }
                        Spacer()
                        Button {
                            self.wordChosen = word
                            self.isShowingWordCard = true
                        } label: {
                                Image(systemName: "arrow.right")
                                    .resizable(resizingMode: .stretch)
                                    .frame(width: 25, height: 20)
                                    .padding()
                                    .foregroundColor(barbiePink)
                                
                            }
                    }
                }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea([.bottom, .trailing, .leading])
            Spacer()
        }
        .padding(.bottom)
        }.edgesIgnoringSafeArea(.bottom)
    }
    }
}

