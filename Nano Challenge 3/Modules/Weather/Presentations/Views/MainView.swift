//
//  MainView.swift
//  Nano Challenge 3
//
//  Created by Nafis-Macbook on 14/07/24.
//

import SwiftUI

struct MainView: View {
    @State var segmentedSelection = 0
    @StateObject private var weatherManager = WeatherManager()
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            SearchView(selectedDate: $selectedDate, weatherManager: weatherManager)

            Picker(selection: $segmentedSelection, label: Text("text")) {
                Text("Temp").tag(0)
                Text("Rain").tag(1)
                Text("AQI").tag(2)
                Text("UV").tag(3)
                Text("Vit D").tag(4)
            }
            .pickerStyle(.segmented)
            .padding()

            ContentComponent(contentModel: getContentModel(), selectedDate: $selectedDate, weatherManager: weatherManager)
            
            Spacer()
        }
        .background(.teal.opacity(0.2))
    }

    private func getContentModel() -> ContentModel {
        switch segmentedSelection {
        case 0:
            return getTemperatureModel()
        case 1:
            return getRainModel()
        case 2:
            return getAirQualityModel()
        case 3:
            return getUVModel()
        case 4:
            return getVitaminDModel()
        default:
            return getTemperatureModel()
        }
    }

    private func getTemperatureModel() -> ContentModel {
        // Logic to determine Good, Moderate, Bad based on weather data
        let temperature = weatherManager.curWeather?.temperature.converted(to: .celsius).value ?? 0
        print("Temperature: \(temperature)")
        if temperature > 0 && temperature < 32 {
            return ContentModel.goodTempModel
        } else if temperature > 32 && temperature < 38 {
            return ContentModel.modTempModel
        } else if temperature > 38 {
            return ContentModel.badTempModel
        } else {
            return ContentModel.dummy
        }
    }

    private func getRainModel() -> ContentModel {
        // Logic to determine Good, Moderate, Bad based on weather data
        let precipitationChance = (weatherManager.curWeather?.precipitationChance ?? 0) * 100
        print("Precipitation Chance: \(precipitationChance)")
        if precipitationChance > 0 && precipitationChance < 20 {
            return ContentModel.goodRainModel
        } else if precipitationChance > 20 && precipitationChance < 80 {
            return ContentModel.modRainModel
        } else if precipitationChance > 80 {
            return ContentModel.badRainModel
        } else {
            return ContentModel.dummy
        }
    }

    private func getAirQualityModel() -> ContentModel {
        // Logic to determine Good, Moderate, Bad based on weather data
        return ContentModel(status: Phrases.AirQuality.Good.status, title: Phrases.AirQuality.Good.title, detail: Phrases.AirQuality.Good.detail, imageName: "hot")
    }

    private func getUVModel() -> ContentModel {
        // Logic to determine Good, Moderate, Bad based on weather data
        let uvIndex = weatherManager.curWeather?.uvIndex.value ?? 0
        print("UV Index: \(uvIndex)")
        if uvIndex > 0 && uvIndex < 2 {
            return ContentModel.goodUvModel
        } else if uvIndex > 2 && uvIndex < 7 {
            return ContentModel.modUvModel
        } else if uvIndex > 7 {
            return ContentModel.badUvModel
        } else {
            return ContentModel.dummy
        }
    }

    private func getVitaminDModel() -> ContentModel {
        // Logic to determine Good, Moderate, Bad based on weather data
        return ContentModel(status: Phrases.VitaminD.Good.status, title: Phrases.VitaminD.Good.title, detail: Phrases.VitaminD.Good.detail, imageName: "hot")
    }
}

#Preview {
    MainView()
}
