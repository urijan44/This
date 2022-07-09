//
//  MovieSearchInteractor.swift
//  
//
//  Created by hoseung Lee on 2022/07/10.
//

import Foundation
import Combine
import ThisDataLayer

protocol MovieSearchInteractorInterface {
  func fetchSearchResult(request: MovieSearchUseCase.MovieSearchMessage.Request) -> Future<MovieSearchUseCase.MovieSearchMessage.Response, Error>
}

struct MovieSearchInteractor {
  private let repository: TMDBRepositoryInterface

  init(repository: TMDBRepositoryInterface) {
    self.repository = repository
  }

  private func transform(dataAccessObject: MovieSearchResultResponse) -> [Movie] {
    guard let results = dataAccessObject.results else { return [] }
    return results
      .compactMap { movieSearchResult in
      Movie(
        id: "\(movieSearchResult.id ?? -1)",
        title: movieSearchResult.title ?? "unknown",
        releaseDate: releaseDateFormatting(date: movieSearchResult.releaseDate) ,
        genre: genreIDSFormatting(genres: movieSearchResult.genreIDS),
        casting: [],
        boomarked: false,
        imageURLString: movieSearchResult.posterPath ?? "")
    }
  }

  private func releaseDateFormatting(date: String?) -> Date {
    guard let date = date else { return Date() }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: date) ?? Date()
  }

  private func genreIDSFormatting(genres: [Int]?) -> [Genre] {
    guard let genres = genres else { return [] }
    return genres.map { genre in
      let genreName = repository.fetchGenreResult(genreID: genre)
      return Genre(id: genre, name: genreName)
    }
  }
}

extension MovieSearchInteractor: MovieSearchInteractorInterface {
  func fetchSearchResult(request: MovieSearchUseCase.MovieSearchMessage.Request) -> Future<MovieSearchUseCase.MovieSearchMessage.Response, Error> {
    return Future<MovieSearchUseCase.MovieSearchMessage.Response, Error> { promise in
      repository.fetchSearchResult(text: request.searchText, language: "ko-KR", region: "KR") { result in

        switch result {
          case .success(let response):
            guard let movie = transform(dataAccessObject: response).first else {
              promise(.failure(NSError(domain: "영화를 찾을 수 없습니다.", code: -1)))
              return
            }
            let response = MovieSearchUseCase.MovieSearchMessage.Response(movie: movie)
            promise(.success(response))
          case .failure(let error):
            promise(.failure(error))
        }
      }
    }
  }
}
