//
//  CustomImages.swift
//  Weather
//
//  Created by Татьяна Касперович on 16.03.24.
//

import SwiftUI

struct CustomImages: View {
    var body: some View {
        CloudsAndSunView()
    }
}

#Preview {
    CustomImages()
}

struct CloudsAndSunView: View {
    var body: some View {
        ZStack {
            CircleShape(color: Color.theme.lightYellow)
                .frame(width: 100, height: 100)
                .offset(x: 15, y: -40)
                .shadow(color: Color.theme.darkYellow.opacity(0.4), radius: 10, x: 2, y: -3)
                .shadow(color: Color.theme.lightYellow.opacity(0.5), radius: 4, x: 5, y: -3)
          
            
            Text("☁️")
                .font(.system(size: 200))
                .offset(x: -30, y: 10)
                .padding(.leading, 15)
            //.padding(.bottom, 10)
            
            Text("☁️")
                .font(.system(size: 150))
                .offset(x: 45, y: 0)
                .padding(.trailing, 0)
        }
        .padding()
    }
}
