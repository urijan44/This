//
//  TMDBService.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation

struct TMDBService {
  enum TMDBError: Error, LocalizedError {
    case invalidResponse
    case invalidData
    case clientError(Int, String)
    case serverError(Int, String)
    case unknown(String)

    var errorDescription: String? {
      switch self {
        case .invalidResponse:
          return "Invalid Response"
        case .invalidData:
          return "Invalid Data"
        case .clientError(let code, let message):
          return "Client Error: \(code) \(message)"
        case .serverError(let code, let message):
          return "Server Error: \(code) \(message)"
        case .unknown(let message):
          return "Unknown Error: \(message)"
      }
    }
  }

  enum Request {
    enum SearchMovie {
      struct Message {
        let text: String
        let language: String
        let region: String
      }
    }

    enum NowPlaying {
      struct Message {
        let page: Int
      }
    }
  }

  enum Response {
    enum SearchMovie {
      struct Message {
        let data: Data?
        let error: TMDBError?
      }
    }

    enum NowPlaying {
      struct Message {
        let data: Data?
        let error: TMDBError?
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
              message = Response.SearchMovie.Message(data: nil, error: .invalidResponse)
              completion(message)
              return
            }
            switch response.statusCode {
              case 200..<300:
                if let data = data {
                  message = Response.SearchMovie.Message(data: data, error: nil)
                } else {
                  message = Response.SearchMovie.Message(data: nil, error: .invalidData)
                }
              case 400..<500, 500..<600:
                message = Response.SearchMovie.Message(data: nil, error: .clientError(response.statusCode, response.statusCode == 401 ? "인증 정보가 잘못 되었습니다." : response.description))
              default:
                message = Response.SearchMovie.Message(data: nil, error: .unknown("\(response.statusCode)"))
            }
          case .failure(let error):
            message = Response.SearchMovie.Message(data: nil, error: .unknown(error.localizedDescription))
        }
        completion(message)
      }
    }

  func request(
    message: Request.NowPlaying.Message,
    completion: @escaping (Response.NowPlaying.Message) -> Void
  ) {
    provider.request(.nowPlaying(page: message.page)) { result in
      let message: Response.NowPlaying.Message
      switch result {
        case .success((let data, let response)):
          guard let response = response as? HTTPURLResponse else {
            message = Response.NowPlaying.Message(data: nil, error: .invalidResponse)
            completion(message)
            return
          }
          switch response.statusCode {
            case 200..<300:
              if let data = data {
                message = Response.NowPlaying.Message(data: data, error: nil)
              } else {
                message = Response.NowPlaying.Message(data: nil, error: .invalidData)
              }
            case 400..<500, 500..<600:
              message = Response.NowPlaying.Message(data: nil, error: .clientError(response.statusCode, response.statusCode == 401 ? "인증 정보가 잘못 되었습니다." : response.description))
            default:
              message = Response.NowPlaying.Message(data: nil, error: .unknown("\(response.statusCode)"))
          }
        case .failure(let error):
          message = Response.NowPlaying.Message(data: nil, error: .unknown(error.localizedDescription))
      }
      completion(message)
    }
  }
}
