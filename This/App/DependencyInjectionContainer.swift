//
//  DependencyInjectionContainer.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation

struct DependencyInjectionContainer {
  func makeMovieSearchView() -> MovieSearchView {
    let useCase = MockMovieSearchUseCase()
    let configuration = MovieSearchView.Configuration(useCase: useCase)
    return MovieSearchView(configuration: configuration)
  }
}
