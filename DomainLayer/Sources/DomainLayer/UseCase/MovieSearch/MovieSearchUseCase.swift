//
//  MovieSearchUseCase.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation
import Combine

public struct MovieSearchUseCase {
  private let interactor: MovieSearchInteractorInterface

  public init(interactor: MovieSearchInteractorInterface) {
    self.interactor = interactor
  }

  public enum MovieSearchMessage {
    public struct Request {
      let searchText: String
    }

    public struct Response {
      let movie: Movie
    }
  }
}

extension MovieSearchUseCase: MovieSearchUseCaseInterface {
  public func fetchSearcResult(searchText: String) -> AnyPublisher<Movie, Never> {
    let request = MovieSearchMessage.Request(searchText: searchText)
    return interactor.fetchSearchResult(request: request)
      .replaceError(with: .init(movie: Movie.noResult(searchText: searchText)))
      .flatMap(responseProcessor(response:))
      .eraseToAnyPublisher()

  }

  private func responseProcessor(response: MovieSearchMessage.Response) -> AnyPublisher<Movie, Never> {
    let movie = response.movie
    return Just(movie)
    .eraseToAnyPublisher()
  }
}

