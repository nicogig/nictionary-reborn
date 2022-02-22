//
//  CommonViews.swift
//  Nictionary
//
//  Created by Nicola Gigante on 22/02/2022.
//

import Foundation
import SwiftUI
import PureSwiftUI
import PureSwiftUITools
import PureSwiftUIDesign

private struct InnerShadow_Bottom: ViewModifier {
    var color: Color = .gray
    var radius: CGFloat = 0.1
    
    private var colors: [Color] {
        [color.opacity(0.75), color.opacity(0.0), .clear]
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .top, endPoint: .bottom)
                            .frame(height: self.radius * self.minSide(geo)),
                         alignment: .top)
        }
    }
    
    func minSide(_ geo: GeometryProxy) -> CGFloat {
        CGFloat(3) * min(geo.size.width, geo.size.height) / 2
    }
}

struct EdgeBorder: Shape {
    
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border_top(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    func border_bottom(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    func border_gradient(width: CGFloat, edges: [Edge], color: LinearGradient) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).fill(color))
    }
    func innerShadowBottom(color: Color, radius: CGFloat = 0.1) -> some View {
        modifier(InnerShadow_Bottom(color: color, radius: min(max(0, radius), 1)))
    }
}


struct AppBar: View {
    
    @Binding var lookUp: Bool
    var sectionName: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [.init(color:Color(red: 180/255, green: 191/255, blue: 205/255), location: 0.0), .init(color:Color(red: 136/255, green: 155/255, blue: 179/255), location: 0.49), .init(color:Color(red: 128/255, green: 149/255, blue: 175/255), location: 0.49), .init(color:Color(red: 110/255, green: 133/255, blue: 162/255), location: 1.0)]), startPoint: .top, endPoint: .bottom).border_bottom(width: 1, edges: [.bottom], color: Color(red: 45/255, green: 48/255, blue: 51/255)).innerShadowBottom(color: Color(red: 230/255, green: 230/255, blue: 230/255), radius: 0.025)
        VStack {
            Spacer()
            HStack {
                HStack {
                    Button(action:{ self.lookUp = false }) {
                        ZStack {
                            Image("button_back_ipod").resizable().scaledToFit().frame(width:67, height: 40)
                            VStack(alignment: .center, spacing: 0) {
                                Text("Nictionary").font(.system(size: 11)).fontWeight(.bold).foregroundColor(.white).lineLimit(1).padding(.leading, 15.0).frame(width: 55.0).shadow(color: Color.black.opacity(0.6), radius: 0, x: 0.0, y: -1).multilineTextAlignment(.center)
                            }.offset(x:-3)
                        }.padding(.leading, 5.5)
                    }
                }.padding(.trailing)
                Spacer()
                Text(sectionName).fontWeight(.bold).ps_innerShadow(Color.white, radius: 0, offset: 1, angle: 180.degrees, intensity: 0.07).font(.system(size: 22)).shadow(color: Color.black.opacity(0.21), radius: 0, x: 0.0, y: -1).padding(.trailing)
                Spacer()
                HStack {
                    Button(action:{  }) {
                        ZStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text(" ").font(.system(size: 11)).fontWeight(.bold).foregroundColor(.white).lineLimit(1).padding(.leading, 15.0).frame(width: 55.0).shadow(color: Color.black.opacity(0.6), radius: 0, x: 0.0, y: -1).multilineTextAlignment(.center)
                            }.offset(x:-3)
                        }.padding(.leading, 5.5)
                    }
                }
            }
            Spacer()
        
        }
        }.frame(height:60).padding(.top, -55.0)
    }
}

struct Button_bg: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15).fill(barbiePink)
            RoundedRectangle(cornerRadius: 15).stroke(darkerPink, lineWidth: 4).shadow(color: darkerPink, radius: 3, x: 2, y: 0).clipShape(RoundedRectangle(cornerRadius: 15)).shadow(color: darkerPink, radius: 5, x: -2, y: 0).clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct StatusBar: View {
    
    var geometry: GeometryProxy
    
    var body: some View {
        Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 237/255, green: 244/255, blue: 247/255), Color.init(red: 191/255, green: 199/255, blue: 203/255)]), startPoint: UnitPoint(x: 0.5, y: 0.07), endPoint: .bottom)).frame(width: geometry.size.width, height: geometry.safeAreaInsets.top).edgesIgnoringSafeArea(.all).shadow(radius: 10)
    }
}

