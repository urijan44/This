//
//  DependencyInjectionContainer.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation
import ThisDataLayer
import DomainLayer
import ThisPresentationLayer

struct DependencyInjectionContainer {
  func makeMovieSearchView() -> MovieSearchView {
    let repository = TMDBRepository()
    let interactor = MovieSearchInteractor(repository: repository)
    let useCase = MovieSearchUseCase(interactor: interactor)
    let configuration = MovieSearchView.Configuration(useCase: useCase)
    return MovieSearchView(configuration: configuration)
  }
}
