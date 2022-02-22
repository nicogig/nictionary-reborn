//
//  RandomCardView.swift
//  Nictionary
//
//  Created by Nicola Gigante on 22/02/2022.
//

import SwiftUI

struct RandomCardView: View {
    
    @Binding var randomCard: Bool
    
    var word: Word
    var sectionName: String
    
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                StatusBar(geometry: geometry)
                AppBar(lookUp: $randomCard, sectionName: sectionName)
                Spacer()
                CardView(word: word,
                         image: word.image,
                         onRemove: { Removedword in } )
                .frame(width: 350, height: 450)
                Spacer()
            }
        }
    }
}
