//
//  MainFeature.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Combine
import ComposableArchitecture
import Foundation

@Reducer
struct MainFeature {
    @ObservableState
    struct State {
        public var isLoading: Bool = false
        public var errorMessage: String?
        public var searchText: String = ""
        public var cityList: [CityListAPI.Response] = []
        public var filterCityList: [CityListAPI.Response] = [.init(id: 1, name: "mock", country: "mmock", coord: .init(lon: 0.0, lat: 0.0))]
        public var showCityList: [CityListAPI.Response] = []
        public var currentWeather: CurrentWeather = .mock()
        public var threeHoursInfo: [ThreeHoursInfo] = [.mock()]
        public var fiveDaysInfo: [FiveDaysInfo] = []
        public var mapViewInfo: MapInfo = .mock()
        public var additionalInfo: AdditionalInfo = .mock()
    }

    enum Action {
        case searching(String)
        case searchItemTap(CityListAPI.Response)
        case loadMore(index: Int)
        case fetchSearchList
        case fetchSearchListResponse(Result<[CityListAPI.Response], APIError>)
        case fetchWeather(WeatherAPI.Request)
        case fetchWeatherResponse(Result<WeatherAPI.Response, APIError>)
        case fetchForeCast(ForecastAPI.Request)
        case fetchForeCastResponse(Result<ForecastAPI.Response, APIError>)
    }

    @Dependency(\.mainAppEnvironment) var mainAppEnvironment
    @Dependency(\.foreCastAppEnvironment) var foreCastAppEnvironment
    @Dependency(\.cityListAppEnvironment) var cityListAppEnvironment

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .searching(searchText):
                state.searchText = searchText

                if searchText.isEmpty {
                    state.showCityList = state.cityList.prefix(20).map { $0 }
                } else {
                    state.showCityList = state.cityList
                        .filter { $0.name?.lowercased().hasPrefix(searchText.lowercased()) ?? false }

                    state.filterCityList = state.cityList
                        .filter { $0.name?.lowercased().hasPrefix(searchText.lowercased()) ?? false }
                }

                return .none
            case .searchItemTap:
                return .none
            case let .loadMore(index: index):
                return .none
            case .fetchSearchList:
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    let result = try await cityListAppEnvironment.fetchCityList()
                    await send(.fetchSearchListResponse(result))
                }
            case let .fetchSearchListResponse(.success(info)):
                print("DEBUG: API CITY > response = \(info.count)")
                state.isLoading = false
                state.cityList = info
                state.errorMessage = nil
                return .none
            case let .fetchSearchListResponse(.failure(error)):
                print("ERROR SEARCH CITY LIST \(error.localizedDescription)")
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none
            case let .fetchWeather(request):
                print("Debug API > request = \(request)")
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    let result = try await mainAppEnvironment.fetchWeather(request)
                    await send(.fetchWeatherResponse(result))
                }
            case let .fetchWeatherResponse(.success(info)):
                print("Debug API > response = \(info)")
                state.isLoading = false
                state.currentWeather = createCurrentWeather(info)
                state.mapViewInfo = .init(name: info.name, lat: info.coord?.lat, lon: info.coord?.lon)
                state.additionalInfo = createAdditionalInfo(info)
                return .none
            case let .fetchWeatherResponse(.failure(info)):
                state.isLoading = false
                state.errorMessage = info.localizedDescription
                return .none
            case let .fetchForeCast(request):
                print("DEBUG: API fetchForeCast > request = \(request)")
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    let result = try await foreCastAppEnvironment.fetchForecast(request)
                    await send(.fetchForeCastResponse(result))
                }
            case let .fetchForeCastResponse(.success(info)):
                print("DEBUG: API 결과 > response = \(info)")
                state.isLoading = false
                state.threeHoursInfo = createThreeHouresInfo(info)
                state.fiveDaysInfo = createFiveDaysInfo(response: info)
                return .none
            case let .fetchForeCastResponse(.failure(info)):
                state.isLoading = false
                state.errorMessage = info.localizedDescription
                return .none
            }
        }
    }

    private func createCurrentWeather(_ response: WeatherAPI.Response) -> CurrentWeather {
        guard let name = response.name,
              let description = response.weather?.first?.description,
              let temp = response.main?.temp,
              let tempMin = response.main?.temp_min,
              let tempMax = response.main?.temp_max,
              let imageString = response.weather?.first?.imageString
        else { return CurrentWeather.mock() }

        return .init(name: name,
                     description: description,
                     temp: String(format: "%.1f", temp),
                     tempMin: String(format: "%.1f", tempMin),
                     tempMax: String(format: "%.1f", tempMax),
                     imageString: imageString)
    }

    private func createAdditionalInfo(_ response: WeatherAPI.Response) -> AdditionalInfo {
        guard let humidity = response.main?.humidity,
              let clouds = response.clouds?.all,
              let wind_speed = response.wind?.speed
        else { return AdditionalInfo.mock() }

        return .init(
            humidity: String(humidity),
            clouds: String(clouds),
            wind_speed: String(format: "%.2f", wind_speed)
        )
    }

    private func createThreeHouresInfo(_ response: ForecastAPI.Response) -> [ThreeHoursInfo] {
        var infoList: [ThreeHoursInfo] = []
        let curTemp = MainFeature.State().currentWeather.temp?.components(separatedBy: ".").first

        infoList.append(.init(
            hours: "Now",
            icon: MainFeature.State().currentWeather.imageString,
            temp: curTemp
        ))

        guard let list = response.list else { return [] }

        for i in 1 ..< 16 {
            infoList.append(
                .init(
                    hours: "\(list[i].hour ?? "")h",
                    icon: list[i].weather?.first?.imageString,
                    temp: String(format: "%.0f", list[i].main?.temp ?? "")
                )
            )
        }

        return infoList
    }

    private func createFiveDaysInfo(response: ForecastAPI.Response) -> [FiveDaysInfo] {
        var infoList: [FiveDaysInfo] = []

        guard let list = response.list else { return [] }

        let filteredList = list.filter { $0.dtTxt!.contains("00:00:00") }

        for i in filteredList {
            infoList.append(
                .init(day: getDayOfWeek(from: i.dtTxt ?? "") ?? "",
                      icon: i.weather?.first?.imageString,
                      tempMax: String(format: "%.0f", i.main?.tempMax ?? ""),
                      tempMin: String(format: "%.0f", i.main?.tempMin ?? ""))
            )
        }

        return infoList
    }

    func getDayOfWeek(from dt_txt: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"

        if let date = dateFormatter.date(from: dt_txt) {
            let today = Date()

            let calendar = Calendar.current
            let todayComponents = calendar.dateComponents([.year, .month, .day], from: today)
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)

            if todayComponents == dateComponents {
                return "Today"
            }

            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "EEEE"

            let dayOfWeekInEnglish = dateFormatter.string(from: date)
            return dayOfWeekInEnglish
        }
        return nil
    }
}
