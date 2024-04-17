//
//  ContentView.swift
//  Weather
//
//  Created by Татьяна Касперович on 27.08.23.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: WeatherViewModel
    //    @State private var metric: MetricsSystem = .metric
    //
    //    enum MetricsSystem: String, CaseIterable, Identifiable {
    //        case metric = "Celsie"
    //        case farengate = "Farengate"
    //        var id: Self { self }
    //    }
    
    let calendar = Calendar.current
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Search Line.....
                        SearchLineView(location: $viewModel.location, viewModel: viewModel)
                      
                        if let weather = viewModel.forecasts.first {
                            // Large Title...
                            LargeTitleView(weatherForecast: weather)

                            // Time's Forecast.....
                            TimesForecastView(viewModel: viewModel, date: Date.now)
                            
                            Divider()
                                .padding(.bottom)
                            
                            // Next 5-Days...
                            ZStack {
                                BackgroundStarsView()
                                
                                VStack {
                                    HStack {
                                        Text("Next 5-Days")
                                        Spacer()
                                    }
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.theme.fontColor)
                                    .padding(.horizontal, 20)
                                    
                                    ForEach(1..<6) { daysToAdd in
                                        if let nextDate = calendar.date(byAdding: .day, value: daysToAdd, to: viewModel.currentDate) {
                                            
                                            NavigationLink {
                                                DayForecastsView(viewModel: viewModel, date: nextDate)
                                            } label: {
                                                if let forecast = viewModel.forecasts.filter({$0.day == viewModel.dateFormatter(date: nextDate)}).first {
                                                    DayCardView(weatherForecast: forecast)
                                                }
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        
                        } else {
                            Text(viewModel.errorAlert)
                                .foregroundStyle(Color.theme.fontColor)
                                .padding()
                        }
                    }
                }
            }
            .onAppear{
                  viewModel.getForecast()
                //viewModel.getWeatherForecast()
            }
        }
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                ContentView()
                    .environmentObject(WeatherViewModel())
            }
        }
    }
    
    struct SearchLineView: View {
        @Binding var location: String
        var viewModel: WeatherViewModel
        
        var body: some View {
            HStack {
                HStack {
                    if location == "" {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                    }
                    
                    TextField("Enter city...", text: $location, onCommit: {
                        viewModel.getForecast()
                    })
                    
                    Spacer()
                    
                    if location != "" {
                        Button {
                            viewModel.location = ""
                            viewModel.errorAlert = ""
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                .background( RoundedRectangleShape(color: Color.theme.shapeBlue, radius: 25).opacity(0.2))
                
                if location != "" {
                    Button {
                       // viewModel.location = textFieldText
                        viewModel.getForecast()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.theme.fontColor)
                            .padding()
                            .background( RoundedRectangleShape(color: Color.theme.shapeBlue, radius: 25))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }
    
    struct LargeTitleView: View {
        var weatherForecast: ForecastModel
        
        var body: some View {
                    VStack {
                        Text(weatherForecast.conditionImage)
                            .shadow(color: Color.theme.shapeBlue, radius: 5)
                            .font(Font.custom("SF Pro Display", size: 100))
                        
                        Text(weatherForecast.city.name)
                            .lineLimit(1)
                            .font(Font.custom("SF Pro Display", size: 34))
                            .kerning(0.374)
                            .multilineTextAlignment(.center)
                        
                        Text("\(weatherForecast.temperatureString)°")
                            .font(
                                Font.custom("SF Pro Display", size: 86)
                                    .weight(.thin)
                            )
                            .kerning(0.374)
                            .multilineTextAlignment(.center)
                        
                        Text(weatherForecast.list.weather[0].description.capitalized)
                            .font(
                                Font.custom("SF Pro Display", size: 20)
                                    .weight(.semibold)
                            )
                            .kerning(0.38)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.theme.fontColor)
                        
                        Text("L:\(weatherForecast.temperatureMinString)°  H:\(weatherForecast.temperatureMaxString)°")
                            .font(Font.custom("SF Pro Display", size: 20))
                            .kerning(0.374)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .foregroundStyle(Color.white)
        }
    }
    
    struct TimesForecastView: View {
        @State var selectedDay = "" // dt
        
        private static var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d"
            return dateFormatter
        }
        
        var viewModel: WeatherViewModel
        var date: Date
        
        var body: some View {
            // Time's Forecast.....
            VStack {
                HStack {
                    Text("Today")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(viewModel.dateFormatter(date: date))
                        .padding()
                        .fontWeight(.light)
                }
                .foregroundStyle(Color.theme.shapeBlue)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 7) {
                        
                        ForEach(viewModel.forecasts.filter({$0.day == viewModel.dateFormatter(date: date)}), id: \.time) { day in
                            
                            Button {
                                withAnimation(.easeInOut){
                                    selectedDay = day.time
                                }
                            } label: {
                                VStack {
                                    VStack(alignment: .center, spacing: 10) {
                                        Text("\(day.time)")
                                            .font(Font.custom("SF Pro Text", size: 15).weight(.semibold))
                                        
                                        Text(day.conditionImage).frame(width: 32, height: 32, alignment: .center)
                                        
                                        Text("\(day.list.main.humidity)%")
                                            .font(Font.custom("SF Pro Text", size: 13).weight(.semibold))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(selectedDay == day.time ? Color.theme.lightYellow : Color.theme.shapeBlue)
                                        
                                        Text("\(day.temperatureString)°")
                                            .font(Font.custom("SF Pro Display", size: 20))
                                            .kerning(0.38)
                                    }
                                    .foregroundColor(Color.theme.backgroundWhite)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 16)
                                    .background(RoundedRectangleShape(color: Color.theme.shapeBlue, radius: 30)
                                        .opacity(selectedDay == day.time ? 1 : 0.2)
                                    )
                                }
                            }
                        }
                        
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding(.bottom)
        }
        
    }
    
    struct DayCardView: View {
        var weatherForecast: ForecastModel
        
        var body: some View {
            ZStack {
                RoundedRectangleShape(color: Color.theme.shapeBlue, radius: 30)
                    .clipShape(CShape())
                    .contentShape(CShape())
                    .shadow(color: Color.theme.shapeBlue, radius: 1, x: 4, y: -2)
                
                VStack {
                    HStack {
                        Text(weatherForecast.day)
                            .bold()
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .bottom) {
                        Text("\(weatherForecast.temperatureString)°")
                            .font(Font.custom("SF Pro Display", size: 36).weight(.thin))
                            .kerning(0.3)
                            .multilineTextAlignment(.center)
                        
                        Text(weatherForecast.list.weather[0].description)
                            .font(Font.custom("SF Pro Text", size: 13))
                        
                        Spacer()
                        
                        Text(weatherForecast.conditionImage)
                            .shadow(color: Color.theme.shapeBlue, radius: 5)
                            .font(Font.custom("SF Pro Display", size: 70))
                            .padding(.horizontal, 5)
                        
                        Text("L:\(weatherForecast.temperatureMinString)°  H:\(weatherForecast.temperatureMaxString)°")
                            .font(Font.custom("SF Pro Text", size: 13))
                        //                                Text("Montreal, Canada")
                        //                                     .font(Font.custom("SF Pro Text", size: 17))
                    }
                    .padding(.leading)
                }
                .foregroundStyle(Color.theme.backgroundWhite)
                .padding()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
    }
