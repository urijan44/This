//
//  TMDBRepository.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation

public protocol TMDBRepositoryInterface {
  func fetchSearchResult(text: String, language: String, region: String, completion: @escaping (Result<MovieSearchResultResponse, Error>) -> Void)
  func fetchGenreResult(genreID: Int) -> String
}

public struct TMDBRepository {
  private let service = TMDBService()
  private var genre: [Int: String] = [:]
  public init() {
    genre = genreUpdate()
  }
  
  private func genreUpdate() -> [Int: String] {
    guard
      let url = Bundle.module.url(forResource: "TMDBGenre", withExtension: "json"),
      let data = try? Data(contentsOf: url),
      let response = try? JSONDecoder().decode(GenreResponse.self, from: data)
    else { return [:] }
    var update: [Int: String] = [:]

    response.genres?.forEach({ genre in
      guard
        let id = genre.id,
        let name = genre.name else { return }
      update.updateValue(name, forKey: id)
    })

    return update
  }
}

extension TMDBRepository: TMDBRepositoryInterface {
  public func fetchSearchResult(text: String, language: String, region: String, completion: @escaping (Result<MovieSearchResultResponse, Error>) -> Void) {
    service.request(message: .init(text: text, language: language, region: region)) { result in
      if let error = result.error {
        completion(.failure(error))
        return
      }

      guard let data = result.data else {
        completion(.failure(NSError(domain: "No data", code: -1)))
        return
      }

      do {
        let decoded = try JSONDecoder().decode(MovieSearchResultResponse.self, from: data)
        completion(.success(decoded))
      } catch let error {
        completion(.failure(error))
      }
    }
  }

  public func fetchGenreResult(genreID: Int) -> String {
    genre[genreID] ?? "unknown"
  }
}
