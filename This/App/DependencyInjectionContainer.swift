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
  let repository = TMDBRepository()
  func makeMovieSearchView() -> MovieSearchView {
    let interactor = MovieSearchInteractor(repository: repository)
    let useCase = MovieSearchUseCase(interactor: interactor)
    let configuration = MovieSearchView.Configuration(useCase: useCase)
    return MovieSearchView(configuration: configuration)
  }

  func makeNowPlayingMovieListView() -> NowPlayingMovieListView {
    let interactor = NowPlayingMovieListInteractor(repository: repository)
    let useCase = NowPlayingMovieListUseCase(interactor: interactor)
    let configuration = NowPlayingMovieListView.Configuration(useCase: useCase)
    let view = NowPlayingMovieListView(configuration: configuration)
    return view
  }
}
