//
//  TabButton.swift
//  Nictionary
//
//  Created by Nicola Gigante on 03/02/2022.
//

import SwiftUI

struct TabButton : View {
    
    var image : String
    var tabName: String
    @Binding var selectedTab : String
    var geometry: GeometryProxy
    var body: some View{
        Button(action: {
            selectedTab = image
        }) {
            ZStack {
                if selectedTab == image {
                    RoundedRectangle(cornerRadius: 3).fill(Color.white.opacity(0.1)).frame(width: geometry.size.width/5 - 5, height: 51).blendMode(.screen)
                    VStack(spacing: 2) {
                        ZStack {
                            Image(systemName: image).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 30.5, height: 30.5).overlay(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 205/255, green: 233/255, blue: 249/255), Color(red: 75/255, green: 220/255, blue: 251/255)]), startPoint: .top, endPoint: .bottom)
                            ).mask(Image(systemName: image).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 30.5, height: 30.5)).offset(y:-0.5)
                            
                            Image(systemName: image).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30).overlay(
                                ZStack {
                                    LinearGradient(gradient: Gradient(stops: [.init(color: Color(red: 197/255, green: 210/255, blue: 229/255), location: 0), .init(color: Color(red: 99/255, green: 162/255, blue: 216/255), location: 0.47), .init(color: Color(red: 0/255, green: 145/255, blue: 230/255), location: 0.49), .init(color: Color(red: 21/255, green: 197/255, blue: 252/255), location: 1)]), startPoint: .top, endPoint: .bottom).rotationEffect(Angle(degrees: image == "More" ? 0 : -15)).frame(width: image == "More" ? 40 : 40, height: image == "Keypad" ? 38 : image == "Contacts" ? 34 : 30).brightness(0.095).offset(y: image == "Artists" ? 2 : 0)
                                }
                            ).mask(Image(systemName: image).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: image == "Keypad" ? 25 : image == "Voicemail" ? 37.5 : 30, height: 30)).shadow(color: Color.black.opacity(0.6), radius:2.5, x: 0, y:2.5)
                        }
                        HStack {
                            Spacer()
                            Text(tabName).foregroundColor(.white).font(.custom("Helvetica Neue Bold", fixedSize: 11))
                            Spacer()
                        }
                    }
                } else {
                    VStack(spacing: 2) {
                        Image(systemName: image).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: image == "Keypad" ? 25 : image == "Voicemail" ? 37.5 : 30, height: 30).overlay(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 157/255, green: 157/255, blue: 157/255), Color(red: 89/255, green: 89/255, blue: 89/255)]), startPoint: .top, endPoint: .bottom)
                        ).mask(Image(systemName: image).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).frame(width: image == "Keypad" ? 25 : image == "Voicemail" ? 37.5 : 30, height: 30)).shadow(color: Color.black.opacity(0.75), radius: 0, x: 0, y: -1)
                        HStack {
                            Spacer()
                            Text(tabName).foregroundColor(Color(red: 168/255, green: 168/255, blue: 168/255)).font(.custom("Helvetica Neue Bold", fixedSize: 11))
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
