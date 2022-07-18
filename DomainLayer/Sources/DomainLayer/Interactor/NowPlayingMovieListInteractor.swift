//
//  NowPlayingMovieListInteractor.swift
//  
//
//  Created by hoseung Lee on 2022/07/18.
//

import Foundation
import Combine
import ThisDataLayer

public struct NowPlayingMovieListInteractor {
  private let repository: TMDBRepositoryInterface

  public init(repository: TMDBRepositoryInterface) {
    self.repository = repository
  }

  private func transform(dataAccessObject: NowPlayingMovieListResponse) -> NowPlayingMovieListUseCase.Message.Response {
    guard
      let results = dataAccessObject.results,
      let page = dataAccessObject.page,
      let totalPage = dataAccessObject.totalPages
    else { return .init(page: -1, totalPage: -1, movie: [])}

    let movies = results
      .compactMap { result in
        Movie(
          id: "\(result.id ?? -1)",
          title: result.title ?? "unknown",
          releaseDate: releaseDateFormatting(date: result.releaseDate) ,
          genre: genreIDSFormatting(genres: result.genreIDS),
          casting: [],
          boomarked: false,
          imageURLString: "https://image.tmdb.org/t/p/w500/" + (result.posterPath ?? ""),
          overview: result.overview ?? "줄거리가 없습니다.",
          voteRate: String(format: "%.1f", result.voteAverage ?? 0.0),
          originalTitle: result.originalTitle ?? "",
          localTitle: result.title ?? ""
        )
      }
    return .init(page: page, totalPage: totalPage, movie: movies)
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

extension NowPlayingMovieListInteractor: NowPlayingMovieListInteractorInterface {
  public func fetchNowPlayingMovieList(request: NowPlayingMovieListUseCase.Message.Request) -> Future<NowPlayingMovieListUseCase.Message.Response, Error> {
    return Future<NowPlayingMovieListUseCase.Message.Response, Error> { promise in
      repository.fetchNowPlayingMovieList(page: request.page) { result in
        switch result {
          case .success(let response):
            let useCaseResponse = transform(dataAccessObject: response)
            promise(.success(useCaseResponse))
          case .failure(let error):
            promise(.failure(error))
        }
      }
    }
  }
}
