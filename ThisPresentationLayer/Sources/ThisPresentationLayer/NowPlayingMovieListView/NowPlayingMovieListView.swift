//
//  NowPlayingMovieListView.swift
//  
//
//  Created by hoseung Lee on 2022/07/17.
//

import SwiftUI
import DomainLayer

public struct NowPlayingMovieListView: View {
  @ObservedObject private var configuration: Configuration
  @State private var searchText = ""
  public var body: some View {
    ScrollView {
      VStack {
        searchSection
        FilteredList(
          configuration.viewModels,
          filterBy: \.localTitle) { title in
            title.hasSubString(searchText)
          } rowContent: { viewModel in
            MovieRowView(item: viewModel)
          }
      }
    }
    .onAppear {
      configuration.fetchMovieList()
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

  public init(configuration: Configuration) {
    self.configuration = configuration
  }
}

extension String {
  func hasSubString(_ substring: String) -> Bool {
    substring.isEmpty || contains(substring)
  }
}
