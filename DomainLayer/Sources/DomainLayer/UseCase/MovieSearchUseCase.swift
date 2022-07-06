//
//  MovieSearchUseCase.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation
import Combine

protocol MovieSearchInteractorInterface {
  func fetchSearchResult(request: MovieSearchUseCase.MovieSearchMessage.Request) -> AnyPublisher<MovieSearchUseCase.MovieSearchMessage.Response, Error>
}

struct MovieSearchUseCase {
  private let interactor: MovieSearchInteractorInterface

  init(interactor: MovieSearchInteractorInterface) {
    self.interactor = interactor
  }

  enum MovieSearchMessage {
    struct Request {
      let searchText: String
    }

    struct Response {
      let movie: Movie
    }
  }
}

//extension MovieSearchUseCase: MovieSearchUseCaseInterface {
//  func fetchSearcResult(searchText: String) -> AnyPublisher<MovieSearchViewItemInterface, Never> {
//    let request = MovieSearchMessage.Request(searchText: searchText)
//    return Just(MovieSearchView.ViewModel(
//      title: "쥬라기 월드",
//      releaseDateString: "2022/08/12",
//      genreString: "SF",
//      castingString: "크리스 프랫",
//      bookmarked: false,
//      imageURLString: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg"
//    ))
//    .eraseToAnyPublisher()
//  }
//}
