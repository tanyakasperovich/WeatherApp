//
//  CustomShapes.swift
//  Weather
//
//  Created by Татьяна Касперович on 16.03.24.
//

import SwiftUI

struct CustomShapes: View {
    var body: some View {
        VStack {
            CircleShape(color: Color.theme.lightYellow)
                .padding()
            
            RoundedRectangleShape(color: Color.theme.backgroundBlue, radius: 25)
                .padding()
            
            RoundedRectangleShape(color: Color.theme.backgroundBlue, radius: 25)
                .clipShape(CShape())
                .padding()
            
            CurvedShape()
                .padding()
        }
    }
}

#Preview {
    CustomShapes()
}

struct CircleShape: View {
    var color: Color

    var body: some View {
        Circle()
            .foregroundStyle(
                LinearGradient(colors: [.theme.lightYellow, .theme.darkYellow], startPoint: .top, endPoint: .bottomLeading))
              .shadow(color: color.opacity(0.6),radius: 4, x: -4, y: 4)
              .overlay(
                Circle()
                    .stroke(color, lineWidth: 4)
                      .shadow(color: Color.white, radius: 6, x: 7, y: 7)
              )
              .overlay(
                Circle()
                    .stroke(color, lineWidth: 4)
                      .shadow(radius: 6, x: -7, y: -7)
              )
              .clipShape(Circle())
    }
}

struct RoundedRectangleShape: View {
    var color: Color
    var radius: Int
    
    var body: some View {
        Rectangle()
            .cornerRadius(CGFloat(radius))
              .foregroundColor(color)
              .shadow(color: color.opacity(0.6),radius: 4, x: -4, y: 4)
              .overlay(
                  RoundedRectangle(cornerRadius: CGFloat(radius), style: .continuous)
                    .stroke(color, lineWidth: 4)
                      .shadow(color: Color.white, radius: 6, x: 7, y: 7)
              )
              .overlay(
                  RoundedRectangle(cornerRadius: CGFloat(radius), style: .continuous)
                    .stroke(color, lineWidth: 4)
                      .shadow(radius: 6, x: -7, y: -7)
              )
              .clipShape(RoundedRectangle(cornerRadius: CGFloat(radius), style: .continuous))
    }
}

struct CShape: Shape{
    func path(in rect: CGRect) -> Path {
        let startPoint = CGPoint(x: 0, y: 0)
        
        return Path { path in
                        path.move(to: startPoint)
            
            path.addCurve(to: CGPoint(x: rect.width/2, y: 40),
                          control1: CGPoint(x: rect.width/2, y: 0),
                          control2: CGPoint(x: rect.width/2, y: -10))
            
            path.addCurve(to: CGPoint(x: rect.width/2+40, y: rect.height/2),
                          control1: CGPoint(x: rect.width/2, y: rect.height/2),
                          control2: CGPoint(x: rect.width/2+20, y: rect.height/2))
            
           // path.addLine(to: CGPoint(x: rect.width, y: rect.height/2)) // 2
            
            path.addCurve(to: CGPoint(x: rect.width, y: rect.height/2+50),
                          control1: CGPoint(x: rect.width, y: rect.height/2),
                          control2: CGPoint(x: rect.width, y: rect.height/2))
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height)) // 2
            
            path.addLine(to: CGPoint(x: 0, y: rect.height)) // 3
             
//            path.move(to: CGPoint(x: rect.width, y: 130))
//            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
//            path.addLine(to: CGPoint(x: 0, y: rect.height))
//            path.addLine(to: CGPoint(x: 0, y: -20))
        }
    }
}

struct CurvedShape: Shape {
func path(in rect: CGRect) -> Path {
let startPoint = CGPoint(x: rect.width * 0.65, y: 0)
var path = Path()
path.move(to: startPoint)
path.addCurve(to: CGPoint(x: rect.width, y: rect.height/2),
control1: CGPoint(x: rect.width * 0.85, y: 0),
control2: CGPoint(x: rect.width, y: rect.height * 0.1))
path.addCurve(to: CGPoint(x: rect.width / 2, y: rect.height),
control1: CGPoint(x: rect.width, y: rect.height * 0.9),
control2: CGPoint(x: rect.width * 0.75, y: rect.height))
path.addCurve(to: CGPoint(x: 0, y: rect.height * 0.7),
control1: CGPoint(x: rect.width * 0.35, y: rect.height),
control2: CGPoint(x: 0, y: rect.height))
path.addCurve(to: CGPoint(x: rect.width * 0.3, y: rect.height * 0.3),
control1: CGPoint(x: 0, y: rect.height * 0.4),
control2: CGPoint(x: rect.width * 0.17, y: rect.height * 0.45))
path.addCurve(to: startPoint,
control1: CGPoint(x: rect.width * 0.42, y: rect.height * 0.16),
control2: CGPoint(x: rect.width * 0.46, y: 0))
return path
}
}
