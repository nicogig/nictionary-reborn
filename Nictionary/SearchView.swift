//
//  SearchView.swift
//  Nictionary
//
//  Created by Nicola Gigante on 09/02/2022.
//

import SwiftUI
import PureSwiftUI
import PureSwiftUITools
import PureSwiftUIDesign

struct SearchView: View {
    @Binding var search: String
    @State var place_holder: String = ""
    var no_right_padding: Bool?
    @Binding var editing_state: String
    private let cancel_gradient = LinearGradient([(color: Color(red: 164/255, green: 175/255, blue:191/255), location: 0), (color: Color(red: 124/255, green: 141/255, blue:164/255), location: 0.51), (color: Color(red: 113/255, green: 131/255, blue:156/255), location: 0.51), (color: Color(red: 112/255, green: 130/255, blue:155/255), location: 1)], from: .top, to: .bottom)
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [.init(color: Color(red: 252/255, green: 250/255, blue: 250/255), location: 0), .init(color: Color(red: 224/255, green: 228/255, blue: 231/255), location: 0.04), .init(color: Color(red: 180/255, green: 190/255, blue: 198/255), location: 1)]),
                    startPoint: .top,
                    endPoint: .bottom))
            VStack {
                Spacer()
                HStack {
                    HStack {
                        Spacer(minLength: 5)
                        HStack (alignment: .center, spacing: 10) {
                            Spacer(minLength: 1)
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .font(Font.title.weight(.medium))
                                .frame(width: 15, height: 15)
                                .padding(.leading, 5)
                            TextField("Search", text: $search,
                                      onEditingChanged: { (changed) in
                                if changed {
                                    withAnimation() {
                                        editing_state = "Active_Empty"
                                    }
                                } else {
                                    withAnimation() {
                                        editing_state = "None"
                                    }
                                }
                            }) {
                                withAnimation() {
                                    editing_state = "None"
                                }
                            }.onChange(of: search) { _ in
                                if search != "" {
                                    editing_state = "Active"
                                } else {
                                    if editing_state != "None" {
                                        editing_state = "Active_Empty"
                                    }
                                }
                            }
                            .keyboardType(.alphabet)
                            .disableAutocorrection(true)
                            .frame(height:32)
                        }.ps_innerShadow(.capsule(LinearGradient([.white, .white], to:.trailing)), radius: 1.6, offset: CGPoint(0, 1), intensity: 0.7).strokeCapsule(Color(red: 166/255, green: 166/255, blue: 166/255), lineWidth: 0.33).padding(.leading, 5.5).padding(.trailing, 5)
                            .frame(height:32)
                        if editing_state != "None" {
                            Button (action: {
                                hideKeyboard()
                                self.search = ""
                            }){
                                ZStack {
                                    Text("Cancel")
                                        .fontWeight(.bold)
                                        .font(.system(size: 13.5))
                                        .foregroundColor(.white)
                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: 0, y: -0.25)
                                }
                                .frame(width: 59, height: 32)
                                .ps_innerShadow(.roundedRectangle(5.5, cancel_gradient), radius: 0.8, offset: CGPoint(0, 0.6), intensity: 0.7).shadow(color: Color.white.opacity(0.28), radius: 0, x: 0, y: 0.8)
                                .padding(.trailing, 5)
                            }
                        }
                    }
                    .padding([.top, .bottom], 5)
                    .padding(.leading, 5)
                    .cornerRadius(40)
                    Spacer(minLength: 8)
                    
                }
                
                
                Spacer()
            }
        }.frame(height:44)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
