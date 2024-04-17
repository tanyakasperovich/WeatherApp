//
//  WeatherModel.swift
//  Weather
//
//  Created by Татьяна Касперович on 27.08.23.
//

import Foundation

struct ForecastModel: Codable {
    let city: City
    let cod: String
    let list: List
    
    // MARK: - condition
    var conditionImage: String {
        switch list.weather[0].id {
        case 200...232:
            return "🌩️"
        case 300...321:
            return "🌧️"
        case 500...504:
            return "🌦️"
        case 511:
            return "🌨️"
        case 520...531:
            return "🌧️"
        case 600...622:
            return "❄️"
        case 701...762:
            return "🌫️"
        case 771:
            return "💨"
        case 781:
            return "🌪️"
        case 800:
            return "☀️"
        case 801...802:
            return "⛅️"
        case 803...804:
            return "☁️"
        default:
            return "⛅️"
        }
    }
    
    // MARK: - temperature
    var temperatureString: String {
        return String(format: "%.1f", list.main.temp)
    }
    var temperatureMinString: String {
        return String(format: "%.0f", list.main.tempMin)
    }
    var temperatureMaxString: String {
        return String(format: "%.0f", list.main.tempMax)
    }
    
    // MARK: - date, time
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d"
        return dateFormatter
    }

    var day: String {
        return Self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(list.dt)))
    }
    
    private static var dayFormatter: DateFormatter {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EE"
        return dayFormatter
    }
    
    var dayOfTheWeek: String {
        return Self.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(list.dt)))
    }
    
    private static var timeFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }

    var time: String {
        return Self.timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(list.dt)))
    }
}
