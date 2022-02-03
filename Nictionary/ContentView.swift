//
//  ContentView.swift
//  Nictionary
//
//  Created by Nicola Gigante on 02/02/2022.
//

import SwiftUI

let images = [
    Image("card_strip_1").resizable(resizingMode: .stretch),
    Image("card_strip_2").resizable(resizingMode: .stretch),
    Image("card_strip_3").resizable(resizingMode: .stretch),
    Image("card_strip_4").resizable(resizingMode: .stretch),
    Image("card_strip_5").resizable(resizingMode: .stretch),
    Image("card_strip_6").resizable(resizingMode: .stretch)
]

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(modelData.words.count - 1 - id) * 10
        return 350 - offset
    }


    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(modelData.words.count - 1 - id) * 10
    }
    
    private var maxID: Int {
        return self.modelData.words.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        GeometryReader { geometry in
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            VStack (alignment: .center){
                Spacer()
            Button {
                modelData.load()
            } label: {
                VStack (alignment: .center){
                Image(systemName: "arrow.counterclockwise")
                    .foregroundColor(.white)
                    .font(.system(size: 100))
                    Text("Refresh")
                        .foregroundColor(.white)
                }.padding()
                }
                Spacer()
            }.padding()
            HStack(alignment: .center) {
                HStack{
                    ZStack {
                        ForEach (modelData.words) { word in
                            if (self.maxID - 4)...self.maxID ~= word.id {
                                CardView(word: word, image: images.randomElement()!, onRemove: { removedCard in
                                self.modelData.words.removeAll {$0.id == removedCard.id}
                            })
                                .animation(.spring())
                                .frame(width: self.getCardWidth(geometry, id: word.id), height: 450)
                                .offset(x: 0, y: self.getCardOffset(geometry, id: word.id))
                                .padding()
                            }
                        }
                    }
                }.padding()
                Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
