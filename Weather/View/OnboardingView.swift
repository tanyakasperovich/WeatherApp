//
//  OnboardingView.swift
//  Weather
//
//  Created by Татьяна Касперович on 16.03.24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                BackgroundStarsView()
                    .clipShape(Circle())
                Spacer()
            }
            
            VStack {
                VStack {
                        CloudsAndSunView()
                        
                        VStack{
                            Text("Weather")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.theme.fontColor)
                            Text("Weather")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.theme.lightYellow)
                        }
                        .padding()
                    }
                .padding(.bottom)
            
                SearchLineView(location: $viewModel.location, viewModel: viewModel)
                
                HStack {
                    if viewModel.errorAlert != "🔎 No Item" {
                        Text(viewModel.forecasts.first?.city.name ?? "")
                    }
                    
                    Text(viewModel.errorAlert)
                    
                    // .opacity((viewModel.errorAlert == "✅") ? 0 : 1)
                }
                .foregroundStyle(Color.theme.fontColor)
                .padding()
                
                Button(action: {
                    isOnboarding = false
                    viewModel.location = ""
                }, label: {
                    Text("Now Start")
                        .bold()
                        .foregroundColor(Color.theme.fontColor)
                        .padding()
                        .padding(.horizontal)
                        .background(RoundedRectangleShape(color: Color.theme.shapeBlue, radius: 50).opacity(0.2))
                        .padding()
                        .blur(radius: disableForm ?  1.5 : 0.0)
                })
                .disabled(disableForm)
            }
        }
    }
    
    var disableForm: Bool {
        viewModel.errorAlert != "✅"
    }
}

#Preview {
    OnboardingView()
        .environmentObject(WeatherViewModel())
}
