//
//  MainFeaturevIEW.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import ComposableArchitecture
import MapKit
import SwiftUI

struct MainFeatureView: View {
    @Bindable var store: StoreOf<MainFeature>

    var body: some View {
        NavigationView {
            weatherView
        }
    }

    @ViewBuilder
    private var weatherView: some View {
        ScrollView(
            showsIndicators: false
        ) {
            if store.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                currentWeatherView
                threeHoursView
                fiveDaysView
                mapView
                additionalView
            }
        }
        .padding()
        .background(ProjectColor.mainColor)
        .onAppear {
            store.send(.fetchWeather(
                WeatherAPI.Request(
                    lat: "-6.2212776",
                    lon: "106.8434554",
                    appid: nil,
                    units: nil,
                    mode: nil,
                    lang: nil
                )
            ))

            // fetchForeCast
            store.send(.fetchForeCast(
                ForecastAPI.Request(
                    lat: "-6.2212776",
                    lon: "106.8434554",
                    appid: nil,
                    units: nil,
                    mode: nil,
                    cnt: nil,
                    lang: nil
                )
            ))
        }
    }

    @ViewBuilder
    private var threeHoursView: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(store.threeHoursInfo) { info in
                        VStack {
                            Text(info.hours ?? "")
                                .foregroundStyle(.white)
                            Image(info.icon ?? "")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("\(info.temp ?? "")°")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130)
        .background(ProjectColor.subColor)
        .cornerRadius(10)
    }

    @ViewBuilder
    private var fiveDaysView: some View {
        VStack(alignment: .leading) {
            Text("5-Day Weather Forecast")
                .foregroundStyle(.white)
            ForEach(store.fiveDaysInfo) { info in
                VStack {
                    Divider()
                    HStack {
                        Text(info.day ?? "")
                            .foregroundStyle(.white)
                        Spacer()
                        Image(info.icon ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Spacer()
                        Text("Min: \(info.tempMin ?? "")°")
                            .foregroundStyle(.white)
                        Text("Max: \(info.tempMax ?? "")°")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130)
        .background(ProjectColor.subColor)
        .cornerRadius(10)
    }

    @ViewBuilder
    private var currentWeatherView: some View {
        VStack {
            Text(store.currentWeather.name ?? "")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundStyle(.white)

            Text("\(store.currentWeather.temp ?? "")°")
                .font(.system(size: 80))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text(store.currentWeather.description ?? "")
                .font(.title2)
                .foregroundStyle(.white)
            Text("Max: \(store.currentWeather.tempMax ?? "0.0")° | Min: \(store.currentWeather.tempMin ?? "0.0")°")
                .font(.subheadline)
                .foregroundStyle(.white)
        }
        .padding()
    }

    @ViewBuilder
    private var mapView: some View {
        VStack(alignment: .leading) {
            Text("MapView")
                .foregroundStyle(.white)
            Map {
                Marker(
                    store.mapViewInfo.name ?? "",
                    coordinate: CLLocationCoordinate2D(
                        latitude: store.mapViewInfo.lat ?? 0,
                        longitude: store.mapViewInfo.lon ?? 0
                    )
                )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 300)
        .background(ProjectColor.subColor)
        .cornerRadius(10)
    }

    @ViewBuilder
    private var additionalView: some View {
        HStack {
            VStack {
                Text("Humidity")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading], 10)
                    .foregroundStyle(.white)

                Text("\(store.additionalInfo.humidity ?? "")%")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                    .font(.title)
                    .foregroundStyle(.white)
                Spacer()
            }
            .background(ProjectColor.subColor)
            .cornerRadius(10)

            VStack {
                Text("Clouds")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading], 10)
                    .foregroundStyle(.white)

                Text("\(store.additionalInfo.clouds ?? "")%")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                    .font(.title)
                    .foregroundStyle(.white)
                Spacer()
            }
            .background(ProjectColor.subColor)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, minHeight: 150)

        HStack {
            VStack {
                Text("Wind Speed")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading], 10)
                    .foregroundStyle(.white)

                Text("\(store.additionalInfo.wind_speed ?? "")m/s")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                    .font(.title)
                    .foregroundStyle(.white)
                Spacer()
            }
            .background(ProjectColor.subColor)
            .cornerRadius(10)

            Rectangle()
                .fill(ProjectColor.mainColor)
        }
        .frame(maxWidth: .infinity, minHeight: 150)
    }
}
