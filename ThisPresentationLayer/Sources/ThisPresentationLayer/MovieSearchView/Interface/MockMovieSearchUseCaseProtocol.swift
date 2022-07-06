//
//  MockMovieSearchUseCaseProtocol.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation
import Combine
import DomainLayer

public struct MockMovieSearchUseCase: MovieSearchUseCaseInterface {
  public func fetchSearcResult(searchText: String) -> AnyPublisher<Movie, Never> {
    Just(
      Movie(
        id: "",
        title: "쥬라기월드",
        releaseDate: Date(),
        genre: ["SF"],
        casting: ["크리스프랫"],
        boomarked: false,
        imageURLString: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg")
    )
    .eraseToAnyPublisher()
  }

  public init() {}
}


