//
//  TMDBService.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation
import Combine

struct TMDBService {
  enum Request {
    enum searchMovie {
      struct Message {
        let text: String
        let language: String
        let region: String
      }
    }
  }

  enum Response {
    enum searchMovie {
      struct Message {
        let data: Data?
        let response: URLResponse?
      }
    }
  }

  private let provider = NetworkProvider<TMDB>()

  func request(
    message: Request.searchMovie.Message,
    completion: @escaping (Result<Response.searchMovie.Message, Error>) -> Void) {
    provider.request(
      .searchMovie(text: message.text, language: message.language, region: message.region)) { result in
      switch result {
        case .success((let data, let response)):
          completion(.success(Response.searchMovie.Message(data: data, response: response)))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
}
