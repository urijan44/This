//
//  MovieSearchView.swift
//  This
//
//  Created by hoseung Lee on 2022/07/05.
//

import SwiftUI
import Combine

public struct MovieSearchView: View {
  @ObservedObject var configuration: Configuration
  @State private var viewModel: ViewModel = .init(title: "", releaseDateString: "", genreString: "", castingString: "", bookmarked: false, imageURLString: "")
  @State private var image = Image(systemName: "heart")
  @State private var cancellables = Set<AnyCancellable>()
  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 0) {
          posterSection
          descriptionSection
        }
      }
      .navigationTitle(viewModel.title)
    }
    .navigationViewStyle(.stack)
    .searchable(text: $configuration.searchText)
    .onAppear(perform: bind)
  }

  var posterSection: some View {
    AsyncImage(url: URL(string: viewModel.imageURLString)) { phase in
      if let image = phase.image {
        ZStack {
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .animation(.easeIn(duration: 1), value: 0)
            .onAppear {
              self.image = image
            }
          VStack {
            Spacer()
            HStack {
              Spacer()
              bookmarkedButton
            }
          }
        }
      } else {
        if !configuration.searchText.isEmpty {
          ProgressView()
        }
      }
    }
    .padding(8)
  }

  var bookmarkedButton: some View {
    Button(action: {
      viewModel.bookmarked.toggle()
    }, label: {
      Image(systemName: viewModel.bookmarked ? "heart.fill" : "heart")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.red)
        .frame(width: 40, height: 40)
    })
    .padding()
  }

  var descriptionSection: some View {
    HStack(alignment: .top) {
      VStack(spacing: 6) {
        Group {
          Text("제목: \(viewModel.title)")
            .font(.title.weight(.bold))
          Text("개봉일: \(viewModel.releaseDateString)")
            .font(.body)
          Text("장르: \(viewModel.genreString)")
            .font(.body)
          Text("주연배우: \(viewModel.castingString)")
            .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      Link(destination: URL(string: viewModel.imageURLString) ?? URL(fileURLWithPath: "")) {
        Image(systemName: "square.and.arrow.up")
          .resizable()
          .aspectRatio(nil, contentMode: .fit)
          .frame(width: 22)
          .foregroundColor(Color.primary)
      }
    }
    .padding(EdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 16))
  }

  public init(configuration: Configuration) {
    self.configuration = configuration
  }

  private func bind() {
    configuration
      .item
      .compactMap { interface in
        interface as? ViewModel
      }
      .sink { viewModel in
        self.viewModel = viewModel
      }
      .store(in: &cancellables)
  }
}

struct MovieSearchView_Previews: PreviewProvider {
  static var previews: some View {
    MovieSearchView(configuration: .init(useCase: MockMovieSearchUseCase()))
  }
}
