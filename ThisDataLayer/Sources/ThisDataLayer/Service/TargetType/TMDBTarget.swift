//
//  TMDBTarget.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation
enum TMDB: TargetType {
  private var accessToken: String? {
    Bundle.main.infoDictionary?["TMDBAccessToken"] as? String
  }

  case searchMovie(text: String, language: String, region: String)

  var baseURL: String {
    "https://api.themoviedb.org/3"
  }

  var path: String {
    switch self {
      case .searchMovie:
        return "search/movie"

    }
  }

  var method: HTTPMethod {
    switch self {
      case .searchMovie:
        return .get
    }
  }

  var query: [String : String] {
    switch self {
      case .searchMovie(let text, let language, let region):
        return ["text": text, "language": language, "region": region]
    }
  }

  var header: [String : String] {
    ["Authorization": accessToken ?? ""]
  }
}
