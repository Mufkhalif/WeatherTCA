//
//  CityListAPIClient.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import ComposableArchitecture
import Foundation

struct CityListAPIClient {
    var fetchCityList: () async throws -> Result<[CityListAPI.Response], APIError>
}

extension CityListAPIClient: DependencyKey {
    static let liveValue: CityListAPIClient = CityListAPIClient {
        try await withCheckedThrowingContinuation { continuation in
            do {
                guard let url = Bundle.main.url(forResource: "User", withExtension: "json") else {
                    return continuation.resume(returning: .failure(APIError.urlComponentsError))
                }

                let data = try Data(contentsOf: url)

                let info = try JSONDecoder().decode([CityListAPI.Response].self, from: data)
                continuation.resume(returning: .success(info))

//                return try JSONDecoder().decode(User.self, from: data)

//                return try JSONDecoder().decode(User.self, from: data)

//                guard let path = CityListAPI.path else {
//                    return continuation.resume(returning: .failure(APIError.urlComponentsError))
//                }
//
//                guard let jsonString = try? String(contentsOfFile: path) else {
//                    return continuation.resume(returning: .failure(APIError.dataError))
//                }
//
//                guard let data = jsonString.data(using: .utf8) else {
//                    return continuation.resume(returning: .failure(APIError.dataError))
//                }
//
//                let info = try JSONDecoder().decode([CityListAPI.Response].self, from: data)
//                continuation.resume(returning: .success(info))
            } catch {
                return continuation.resume(returning: .failure(APIError.etcError(error: error)))
            }
        }
    }
}
