//
//  NictionaryApp.swift
//  Nictionary
//
//  Created by Nicola Gigante on 02/02/2022.
//

import SwiftUI

@main
struct NictionaryApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .preferredColorScheme(.light)
        }
    }
}
