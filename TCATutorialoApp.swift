//
//  TCATutorialoApp.swift
//  TCATutorialo
//
//  Created by mufkhalif on 14/08/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCATutorialoApp: App {
    var body: some Scene {
        WindowGroup {
            MainFeatureView(store: Store(initialState: MainFeature.State()) {
                MainFeature()
            })
        }
    }
}
