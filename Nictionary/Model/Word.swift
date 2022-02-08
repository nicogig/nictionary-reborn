//
//  Word.swift
//  Nictionary
//
//  Created by Nicola Gigante on 02/02/2022.
//

import Foundation
import SwiftUI

let images = [
    Image("card_strip_1").resizable(resizingMode: .stretch),
    Image("card_strip_2").resizable(resizingMode: .stretch),
    Image("card_strip_3").resizable(resizingMode: .stretch),
    Image("card_strip_4").resizable(resizingMode: .stretch),
    Image("card_strip_5").resizable(resizingMode: .stretch),
    Image("card_strip_6").resizable(resizingMode: .stretch)
]


struct Word: Hashable, Codable, Identifiable {
    var id: Int
    var file: String
    var name: String
    var phon: String
    var def: String
    
    var image: Image { images.randomElement()! }
    
}
