//
//  SearchView.swift
//  TCATutorialo
//
//  Created by mufkhalif on 16/08/24.
//

import ComposableArchitecture
import SwiftUI

struct SearchView: View {
    var store: StoreOf<MainFeature>
    @Environment(\.dismissSearch) private var dismissSearch

    var body: some View {
        ForEach(store.showCityList, id: \.self) { item in
            VStack(alignment: .leading) {
                Text(item.name ?? "")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.country ?? "")
            }
            .onTapGesture {
                dismissSearch()
                store.send(.searchItemTap(item))
            }
            .onAppear {
                if store.showCityList.last == item {
                    print("마지막")
                    store.send(.loadMore(index: store.showCityList.count))
                }
            }
        }
    }
}
