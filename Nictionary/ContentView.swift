//
//  ContentView.swift
//  Nictionary
//
//  Created by Nicola Gigante on 02/02/2022.
//

import SwiftUI
import Collections

let images = [
    Image("card_strip_1").resizable(resizingMode: .stretch),
    Image("card_strip_2").resizable(resizingMode: .stretch),
    Image("card_strip_3").resizable(resizingMode: .stretch),
    Image("card_strip_4").resizable(resizingMode: .stretch),
    Image("card_strip_5").resizable(resizingMode: .stretch),
    Image("card_strip_6").resizable(resizingMode: .stretch)
]

var viewNames: OrderedDictionary = [
    "book.fill": "Nictionary",
    "music.note": "Media",
    "bubble.left.fill": "Social",
    "bus.fill": "Events"
]


struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selectedTab = "book.fill"
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
                .scaledToFill()
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .frame(width: geometry.size.width)
            VStack {
                Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 237/255, green: 244/255, blue: 247/255), Color.init(red: 191/255, green: 199/255, blue: 203/255)]), startPoint: UnitPoint(x: 0.5, y: 0.07), endPoint: .bottom)).frame(width: geometry.size.width, height: geometry.safeAreaInsets.top).edgesIgnoringSafeArea(.all).shadow(radius: 10)
                Spacer()
                switch selectedTab {
                case "book.fill":
                    ZStack {
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
                        HStack(alignment: .center){
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
                    }
                    
                default:
                    VStack (alignment: .center) {
                        ZStack {
                            Image("cardpile")
                                .resizable()
                                .frame(width: 380, height: 450)
                            Image("card_error")
                                .resizable()
                                .frame(width: 360, height: 430)
                        }
                        Text("This feature is not available yet.")
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                }
                
                Spacer()
                ZStack{
                    Rectangle().fill(.black).frame(height:100).ignoresSafeArea().padding(.bottom, -100.0)
                    Rectangle().fill(LinearGradient(gradient: Gradient(stops: [.init(color: Color(red: 0, green: 0, blue: 0), location: 0), .init(color: Color(red: 84/255, green: 84/255, blue: 84/255), location: 0.02), .init(color: Color(red: 59/255, green: 59/255, blue: 59/255), location: 0.04), .init(color: Color(red: 29/255, green: 29/255, blue: 29/255), location: 0.5), .init(color: Color(red: 7.5/255, green: 7.5/255, blue: 7.5/255), location: 0.51), .init(color: Color(red: 7.5/255, green: 7.5/255, blue: 7.5/255), location: 1)]), startPoint: .top, endPoint: .bottom)).frame(height:57)
                    HStack (spacing: 0) {
                        ForEach(viewNames.keys, id:\.self) {
                            TabButton(image: $0, tabName:viewNames[$0]! ,selectedTab: $selectedTab, geometry: geometry)
                        }
                }.frame(height:55)
                }.padding(.bottom, 0)
                
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
