//
//  NowPlayingMovieListView.swift
//  
//
//  Created by hoseung Lee on 2022/07/17.
//

import SwiftUI

struct NowPlayingMovieListView: View {
  @State private var viewModel = ""
  @State private var searchText = ""
  var body: some View {
    ScrollView {
      VStack {
        searchSection
//        FilteredList(<#T##items: [Identifiable]##[Identifiable]#>, filterBy: <#T##KeyPath<Identifiable, FilterKey>#>, isIncluded: <#T##(FilterKey) -> Bool#>, rowContent: <#T##(Identifiable) -> View#>)
      }
    }
  }

  var searchSection: some View {
    HStack(spacing: 6) {
      Image(systemName: "magnifyingglass")
        .foregroundColor(.secondary)
      TextField("영화 제목을 입력해 보세요!", text: $searchText)
    }
    .padding()
  }
}

struct FilteredList<Element, FilterKey, RowContent>: View where Element: Identifiable, RowContent: View {
  private let items: [Element]
  private let filterKey: KeyPath<Element, FilterKey>
  private let isIncluded: (FilterKey) -> Bool
  private let rowContent: (Element) -> RowContent

  var body: some View {
    filteredBody
  }

  var filteredBody: some View {
    let filteredItem = items.filter {
      isIncluded($0[keyPath: filterKey])
    }
    return ForEach(filteredItem, id: \.id) { key in
      rowContent(key)
    }
  }

  init(
    _ items: [Element],
    filterBy key: KeyPath<Element, FilterKey>,
    isIncluded: @escaping (FilterKey) -> Bool,
    @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
    self.items = items
    self.filterKey = key
    self.isIncluded = isIncluded
    self.rowContent = rowContent
  }
}

struct NowPlayingMovieListView_Previews: PreviewProvider {
  static var previews: some View {
    NowPlayingMovieListView()
  }
}
