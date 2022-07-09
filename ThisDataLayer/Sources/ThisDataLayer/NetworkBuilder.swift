//
//  NetworkBuilder.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

public protocol TargetType {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var query: [String: String] { get }
  var header: [String: String] { get }
}

public struct NetworkProvider<Target: TargetType> {

  public enum IntenalError: Error, LocalizedError {
    case invalidURL

    public var errorDescription: String? {
      switch self {
        case .invalidURL:
          return "URL Building Failure"
      }
    }
  }

  public typealias Response = (Data?, URLResponse?)

  public func request(_ target: Target, completion: @escaping (Result<Response, Error>) -> Void)  {
    do {
      let request = try makeRequest(target: target)

      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }

        if let response = response, let data = data {
          completion(.success((data, response)))
        }

      }.resume()

    } catch let error {
      completion(.failure(error))
    }
  }

  private func makeRequest(target: Target) throws -> URLRequest {
    guard var urlComponents = URLComponents(string: target.baseURL) else { throw IntenalError.invalidURL }
    urlComponents.path = target.path
    urlComponents.queryItems = target.query.map{ URLQueryItem(name: $0.key, value: $0.value) }
    guard let url = urlComponents.url else { throw IntenalError.invalidURL }

    var request = URLRequest(url: url)

    request.httpMethod = target.method.rawValue
    request.allHTTPHeaderFields = target.header
    return request
  }
}
