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

extension MovieSearchUseCase: MovieSearchUseCaseInterface {
  func fetchSearcResult(searchText: String) -> AnyPublisher<Movie, Never> {
    let request = MovieSearchMessage.Request(searchText: searchText)
    return interactor.fetchSearchResult(request: request)
      .replaceError(with: .init(movie: .init(id: "", title: "", releaseDate: Date(), genre: [], casting: [], boomarked: false, imageURLString: "")))
      .flatMap(responseProcessor(response:))
      .eraseToAnyPublisher()

  }

  private func responseProcessor(response: MovieSearchMessage.Response) -> AnyPublisher<Movie, Never> {
    let movie = response.movie
    return Just(movie)
    .eraseToAnyPublisher()
  }
}

