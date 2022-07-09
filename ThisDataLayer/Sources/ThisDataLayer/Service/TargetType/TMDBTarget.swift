//
//  TMDBTarget.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation
enum TMDB: TargetType {
  private var accessToken: String? {

    guard
      let url = Bundle.module.url(forResource: "token", withExtension: "plist"),
      let dictionary = NSMutableDictionary(contentsOf: url) as? Dictionary<String, Any>,
      let token = dictionary["TMDBAccessToken"] as? String
    else {
      return nil
    }
    return token
  }

  case searchMovie(text: String, language: String, region: String)

  var baseURL: String {
    "https://api.themoviedb.org/"
  }

  var path: String {
    switch self {
      case .searchMovie:
        return "/3/search/movie"

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
        return ["query": text, "language": language, "region": region]
    }
  }

  var header: [String : String] {
    ["Authorization": "Bearer " + (accessToken ?? "")]
  }
}
