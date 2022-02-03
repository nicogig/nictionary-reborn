//
//  TabView.swift
//  Nictionary
//
//  Created by Nicola Gigante on 03/02/2022.
//

import SwiftUI
import Collections


struct TabView: View {
    @State var selectedTab = "book.fill"
    var body: some View {
        GeometryReader { geometry in
            ZStack{
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

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
