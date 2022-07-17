//
//  NowPlayingMovieListView.swift
//  
//
//  Created by hoseung Lee on 2022/07/17.
//

import SwiftUI

public struct NowPlayingMovieListView: View {
  @State private var viewModels: [ViewModel] = []
  @State private var searchText = ""
  public var body: some View {
    ScrollView {
      VStack {
        searchSection
        FilteredList(
          viewModels,
          filterBy: \.localTitle) { title in
            title.hasSubString(searchText)
          } rowContent: { viewModel in
            MovieRowView(item: viewModel)
          }
      }
    }
    .onAppear {

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

  public init(viewModels: [ViewModel], searchText: String = "") {
    self.viewModels = viewModels
    self.searchText = searchText
  }
}

extension String {
  func hasSubString(_ substring: String) -> Bool {
    substring.isEmpty || contains(substring)
  }
}

struct NowPlayingMovieListView_Previews: PreviewProvider {
  static var previews: some View {
    NowPlayingMovieListView(viewModels: [])
  }
}

extension NowPlayingMovieListView {
  public struct ViewModel: Identifiable, MovieRowItem {
    private(set) public var id: String
    private(set) public var imageURL: String
    private(set) public var originalTitle: String
    private(set) public var localTitle: String
    private(set) public var voteRate: String
    private(set) public var overview: String

    public init(id: String, imageURL: String, originalTitle: String, localTitle: String, voteRate: String, overview: String) {
      self.id = id
      self.imageURL = imageURL
      self.originalTitle = originalTitle
      self.localTitle = localTitle
      self.voteRate = voteRate
      self.overview = overview
    }
  }
}
