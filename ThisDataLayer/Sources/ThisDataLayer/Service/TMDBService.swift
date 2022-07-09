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
    enum SearchMovie {
      struct Message {
        let text: String
        let language: String
        let region: String
      }
    }
  }

  enum Response {
    enum SearchMovie {
      struct Message {
        let data: Data?
        let error: String?
      }
    }
  }

  private let provider = NetworkProvider<TMDB>()

  func request(
    message: Request.SearchMovie.Message,
    completion: @escaping (Response.SearchMovie.Message) -> Void) {
    provider.request(
      .searchMovie(text: message.text, language: message.language, region: message.region)) { result in
        let message: Response.SearchMovie.Message
      switch result {
        case .success((let data, let response)):
          guard let response = response as? HTTPURLResponse else {
            message = Response.SearchMovie.Message(data: nil, error: "invalid response")
            completion(message)
            return
          }
          switch response.statusCode {
            case 200..<300:
              if let data = data {
                message = Response.SearchMovie.Message(data: data, error: nil)
              } else {
                message = Response.SearchMovie.Message(data: nil, error: "invalid data")
              }

            default:
              message = Response.SearchMovie.Message(data: nil, error: "Client Error")
          }
        case .failure(let error):
          message = Response.SearchMovie.Message(data: nil, error: error.localizedDescription)
      }
        completion(message)
    }
  }
}
