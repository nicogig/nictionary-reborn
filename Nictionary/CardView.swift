//
//  CardView.swift
//  Nictionary
//
//  Created by Nicola Gigante on 02/02/2022.
//

import SwiftUI
import AVKit

struct CardView: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var translation: CGSize = .zero
    @State var isBeingDragged: Bool = false
    @GestureState private var dragGestureActive: Bool = false
    @State var dragOffset: CGSize = .zero
    let wordInfo: Word
    private var onRemove: (_ word: Word) -> Void
    private var thresholdPercentage: CGFloat = 0.3
    var barbiePink = Color(red:253.0/255.0, green: 175.0/255.0, blue: 197.0/255.0)
    var image: Image
    
    init(word: Word, image: Image, onRemove: @escaping (_ word: Word) -> Void) {
        self.wordInfo = word
        self.onRemove = onRemove
        self.image = image
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ZStack {
                    Image("card_front_background")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .shadow(radius: 5)
                    VStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100, style: .circular)
                                .fill(barbiePink)
                            Text("WORD")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }.frame(width: geometry.size.width*0.2, height: geometry.size.height*0.1)
                        Text(wordInfo.name.uppercased())
                            .font(.title)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Text(wordInfo.phon)
                            .foregroundColor(.black)
                        Divider()
                        ScrollView {
                            Text(wordInfo.def)
                                .foregroundColor(.black)
                        }
                        .gesture(DragGesture())
                    }.padding()
                        Spacer()
                        ZStack {
                            image
                                .frame(width: geometry.size.width*0.92, height: geometry.size.height*0.25)
                                .padding(.bottom, -2.5)
                            HStack{
                                Spacer()
                                Button {
                                    let sound = Bundle.main.path(forResource: wordInfo.file, ofType: "m4a")
                                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                                    self.audioPlayer.play()
                                    } label: {
                                        Image("button_play")
                                            .resizable(resizingMode: .stretch)
                                            .frame(width: 60, height: 60)
                                            .padding()
                                        
                                    }
                            }
                        }
                    }.padding()
                    
                }
            }
            .padding(.bottom)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .center)
            .disabled(self.isBeingDragged)
            .gesture(
                DragGesture()
                    .updating($dragGestureActive) { value, state, transaction in
                                state = true
                    }
                    .onChanged { value in
                        self.translation = value.translation
                        self.isBeingDragged = true
                    }.onEnded { value in
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.wordInfo)
                        } else {
                            self.translation = .zero
                            self.isBeingDragged = false
                        }
                    }
            )
            .onChange(of: dragGestureActive) { newIsActiveValue in
                if newIsActiveValue == false {
                    dragCancelled()
                }
            }
            // Here
        }
    }
    
    private func dragCancelled() {
            print("dragCancelled")
        self.translation = .zero
        self.isBeingDragged = false
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        CardView(word: modelData.words[0], image: Image("card_strip_1").resizable(resizingMode: .stretch), onRemove: { _ in
            
        })
            .frame(width: 350, height: 450)
            .padding()
    }
}
