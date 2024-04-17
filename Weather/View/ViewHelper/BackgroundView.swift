//
//  BackgroundView.swift
//  Weather
//
//  Created by Татьяна Касперович on 16.03.24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [.theme.backgroundBlue, .theme.backgroundWhite], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

#Preview {
    ZStack {
        BackgroundView()
        BackgroundStarsView()
       // BackgroundCloudsView(text: "☁️")
    }
}

struct BackgroundStarsView: View {

    var body: some View {
        
        let rows = [GridItem(), GridItem(), GridItem(),  GridItem(), GridItem()]
        
            ZStack {
                LazyVGrid(columns: rows) {
                    ForEach(0...15, id: \.self) { value in
                        Text(" ")
                            .padding()
                        
                        Text(" ")
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 7))
                            .foregroundStyle(Color.theme.lightPurple.opacity(0.5))
                    }
                }
                
                LazyVGrid(columns: rows) {
                    ForEach(0...36, id: \.self) { value in
                        Text("✨")
                            .font(.title2)
                        
                        Text(" ")
                        
                        Text("")
                            .font(.caption)
                    }
                }
            }
            
    }
}

//struct BackgroundCloudsView: View {
//    
//    var text: String
//    
//    var body: some View {
//        
//        let rows = [GridItem(), GridItem(), GridItem(),  GridItem(), GridItem()]
//        
//        ZStack {
//           // LazyVGrid(columns: rows) {
//                //                    ForEach(0...15, id: \.self) { value in
//                //                        Text(" ")
//                //                            .padding()
//                //
//                //                        Text(" ")
//                //
//                //                        Image(systemName: "star.fill")
//                //                            .font(.system(size: 7))
//                //                            .foregroundStyle(Color.theme.lightPurple.opacity(0.5))
//                //                    }
//                //                }
//                
//                LazyVGrid(columns: rows) {
//                    ForEach(0...7, id: \.self) { value in
//                        Text(text)
//                            .font(Font.custom("SF Pro Display", size: 140))
//                            .frame(width: 140)
//                            .opacity(0.2)
//                        
//                        Text(" ")
////
////                        Text("")
////                            .font(.caption)
//                    }
//                }
//            }
//        
//    }
//}
