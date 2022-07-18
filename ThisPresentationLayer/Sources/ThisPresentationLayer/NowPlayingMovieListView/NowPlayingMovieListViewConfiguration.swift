//
//  NowPlayingMovieListViewConfiguration.swift
//  
//
//  Created by hoseung Lee on 2022/07/18.
//

import SwiftUI
import Combine
import DomainLayer

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

    init(movie: Movie) {
      self.id = movie.id
      self.originalTitle = movie.originalTitle
      self.localTitle = movie.localTitle
      self.voteRate = movie.voteRate
      self.overview = movie.overview
      self.imageURL = movie.imageURLString
    }
  }

  enum Action {
    case viewDidLoad
    case currentPresentRow
  }

  public final class Configuration: ObservableObject {
    @Published var viewModels: [ViewModel] = []
    private let useCase: NowPlayingMovieListUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(useCase: NowPlayingMovieListUseCase) {
      self.useCase = useCase
      fetchMovieList()
    }

    func fetchMovieList() {
      useCase.fetchNowPlayMovieList()
        .receive(on: DispatchQueue.main)
        .map { movies in
          movies.map { movie in
            ViewModel(movie: movie)
          }
        }
        .sink { [unowned self] newMovies in
          viewModels.append(contentsOf: newMovies)
        }
        .store(in: &cancellables)
    }
  }
}
