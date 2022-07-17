//
//  NowPlayingMovieListInteractor.swift
//  
//
//  Created by hoseung Lee on 2022/07/18.
//

import Combine
import ThisDataLayer

public struct NowPlayingMovieListInteractor {
  private let repository: TMDBRepositoryInterface

  public init(repository: TMDBRepositoryInterface) {
    self.repository = repository
  }
}

extension NowPlayingMovieListInteractor: NowPlayingMovieListInteractorInterface {
  public func fetchNowPlayingMovieList(request: NowPlayingMovieListUseCase.Message.Request) -> Future<NowPlayingMovieListUseCase.Message.Response, Error> {
    return Future<NowPlayingMovieListUseCase.Message.Response, Error> { promise in

    }
  }
}
