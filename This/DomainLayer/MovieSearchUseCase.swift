//
//  MovieSearchUseCase.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation
import Combine

protocol MovieSearchInteractorInterface {
  func fetchSearchResult(request: MovieSearchMessage.Request) -> AnyPublisher<MovieSearchMessage.Response, Error>
}

enum MovieSearchMessage {
  struct Request {

  }

  struct Response {

  }
}

struct MovieSearchUseCase {
  private let interactor: MovieSearchInteractorInterface

  init(interactor: MovieSearchInteractorInterface) {
    self.interactor = interactor
  }
}

extension MovieSearchUseCase: MovieSearchUseCaseInterface {
  func fetchSearcResult(searchText: String) -> AnyPublisher<MovieSearchViewItemInterface, Never> {
    let request = MovieSearchMessage.Request()
    return Just(MovieSearchView.ViewModel(
      title: "쥬라기 월드",
      releaseDate: "2022/08/12",
      genre: "SF",
      casting: "크리스 프랫",
      bookmarked: false,
      imageURLString: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg"
    ))
    .eraseToAnyPublisher()
  }
}
