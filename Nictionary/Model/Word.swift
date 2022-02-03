//
//  Word.swift
//  Nictionary
//
//  Created by Nicola Gigante on 02/02/2022.
//

import Foundation


struct Word: Hashable, Codable, Identifiable {
    var id: Int
    var file: String
    var name: String
    var phon: String
    var def: String
}
