//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Татьяна Касперович on 27.08.23.
//

import SwiftUI
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var forecasts: [ForecastModel] = []
    @AppStorage("location") var location: String = ""
    //@Published var location: String = ""
    @Published var errorAlert: String = ""
    
    @Published var currentDate = Date()

    var weatherSubscription: AnyCancellable?

    func getForecast() {
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error {
                self.errorAlert = "🔎 No Item"
                print(error.localizedDescription)
            }
            
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude
            {
                guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=6bf1944b42b2e24d215aafc118b1ba6a&units=metric") else { return }
                
                self.weatherSubscription = NetworkingManager.download(url: url)
                    .decode(type: ForecastData.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedWeatherForecasts) in
                        DispatchQueue.main.async {
                            self?.forecasts = returnedWeatherForecasts.list.map {ForecastModel(city: returnedWeatherForecasts.city, cod: returnedWeatherForecasts.cod, list: $0)}
                            self?.location = returnedWeatherForecasts.city.name
                            self?.errorAlert = "✅"
                        }
                        self?.weatherSubscription?.cancel()
                    })
            }
        }
    }
    
//        func getWeatherForecast(){
//            let apiService = APIService.shared
//    
//            CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//                if let lat = placemarks?.first?.location?.coordinate.latitude,
//                   let lon = placemarks?.first?.location?.coordinate.longitude
//                {
//                apiService.getJSON(urlString:
//                    "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=6bf1944b42b2e24d215aafc118b1ba6a&units=metric", dateDecodingStategy: .secondsSince1970) {
//                        (result: Result<ForecastModel,APIService.APIError>) in
//                        switch result {
//                        case .success(let forecast):
//                            self.forecasts = [forecast]
//                        case .failure(let apiError):
//                            switch apiError {
//                            case .error(let errorString):
//                                print(errorString)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    
   
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "E, d"
        return formatter.string(from: date)
    }
    func longFormatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d"
        return dateFormatter.string(from: date)
    }
}
