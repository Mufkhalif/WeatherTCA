//
//  APIError.swift
//  TCATutorialo
//
//  Created by mufkhalif on 15/08/24.
//

import Foundation

public enum APIError: Error {
    case dataError
    case decodingError
    case networkError
    case etcError(error: Error)
    case urlComponentsError
}
