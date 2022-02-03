//
//  ModelData.swift
//  Nictionary
//
//  Created by Nicola Gigante on 02/02/2022.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var words = [Word]()
    
    init() {
        load()
    }

    func load() {
        let data: Data
        guard let file = Bundle.main.url(forResource: "nicitionary.json", withExtension: nil)
        else {
            fatalError("Could not find file in Bundle")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("File data could not be loaded")
        }
        
        do {
            let decoder = JSONDecoder()
            self.words = try decoder.decode([Word].self, from: data)
        } catch {
            fatalError("Could not decode JSON file.")
        }
    }

}

