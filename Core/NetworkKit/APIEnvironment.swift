//
//  APIEnvironment.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import ComposableArchitecture
import Foundation

extension DependencyValues {
    var mainAppEnvironment: MainAPIClient {
        get { self[MainAPIClient.self] }
        set { self[MainAPIClient.self] = newValue }
    }

    var foreCastAppEnvironment: ForecastAPIClient {
        get { self[ForecastAPIClient.self] }
        set { self[ForecastAPIClient.self] = newValue }
    }

    var cityListAppEnvironment: CityListAPIClient {
        get { self[CityListAPIClient.self] }
        set { self[CityListAPIClient.self] = newValue }
    }
}
