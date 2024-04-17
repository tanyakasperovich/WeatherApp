//
//  DayForecastsView.swift
//  Weather
//
//  Created by Татьяна Касперович on 23.03.24.
//

import SwiftUI

struct DayForecastsView: View {
    var viewModel: WeatherViewModel
    var date: Date
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(viewModel.longFormatDate(date: date))
                }
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.fontColor)
                .padding(.horizontal, 20)
                
                ForEach(viewModel.forecasts.filter({$0.day == viewModel.dateFormatter(date: date)}), id: \.time) { item in
                    ForecastCardView(weatherForecast: item)
                }
            }
        }
       
    }
}

#Preview {
    DayForecastsView(viewModel: WeatherViewModel(), date: Date.now)
}

struct ForecastCardView: View {
    var weatherForecast: ForecastModel
    
    var body: some View {
        ZStack {
            RoundedRectangleShape(color: Color.theme.shapeBlue, radius: 30)
                .opacity(0.2)
            
            VStack {
                HStack(alignment: .top) {
                    Text(weatherForecast.time)
                        .font(Font.custom("SF Pro Display", size: 20).weight(.bold))

                    Spacer()
                    
                    Text("\(weatherForecast.temperatureString)°")
                                                .font(Font.custom("SF Pro Display", size: 40).weight(.thin))
                                                .kerning(0.374)
                                                .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                HStack(alignment: .bottom) {
                    Text("L:\(weatherForecast.temperatureMinString)°  H:\(weatherForecast.temperatureMaxString)°")
                        .font(Font.custom("SF Pro Text", size: 18))
                        .foregroundStyle(Color.theme.backgroundWhite).opacity(0.8)
                    
                    Spacer()
                    
                    Text(weatherForecast.conditionImage)
                        .shadow(color: Color.theme.shapeBlue, radius: 5)
                        .font(Font.custom("SF Pro Display", size: 70))
                        .padding(.horizontal, 5)
                    Text(weatherForecast.list.weather[0].description)
                        .font(Font.custom("SF Pro Text", size: 15))
                    .opacity(0.8)
                    
                    Spacer()
                    
                    Text("\(weatherForecast.list.main.humidity)%")
                        .font(Font.custom("SF Pro Text", size: 20))
                    
                }
                .padding(.leading)
            }
            .foregroundStyle(Color.theme.shapeBlue)
            //.foregroundStyle(Color.theme.backgroundWhite)
            .padding()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}
