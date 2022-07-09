//
//  TMDBService.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import Foundation
import Combine

struct TMDBService {
  let provider = NetworkProvider<TMDB>()

  func request() {
    provider.request(.searchMovie(text: "", language: "", region: "")) { result in
      switch result {
        case .success(let data, let response):
          ()
        case .failure(let error):
          ()
      }
    }
  }
}
