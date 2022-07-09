//
//  TMDBRepository.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation

public protocol TMDBRepositoryInterface {
  func fetchSearchResult(text: String, language: String, region: String, completion: @escaping (Result<MovieSearchResultResponse, Error>) -> Void)
}

public struct TMDBRepository {
  private let service = TMDBService()
}

extension TMDBRepository: TMDBRepositoryInterface {
  public func fetchSearchResult(text: String, language: String, region: String, completion: @escaping (Result<MovieSearchResultResponse, Error>) -> Void) {
    service.request(message: .init(text: text, language: language, region: region)) { result in
      if let error = result.error {
        completion(.failure(error))
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
}
