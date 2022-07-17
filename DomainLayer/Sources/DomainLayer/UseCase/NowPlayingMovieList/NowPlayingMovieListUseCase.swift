//
//  NowPlayingMovieListUseCase.swift
//  
//
//  Created by hoseung Lee on 2022/07/18.
//

import Combine

public protocol NowPlayingMovieListInteractorInterface {
  func fetchNowPlayingMovieList(request: NowPlayingMovieListUseCase.Message.Request) -> Future<NowPlayingMovieListUseCase.Message.Response, Error>
}

public final class NowPlayingMovieListUseCase: ObservableObject {

  private let interactor: NowPlayingMovieListInteractorInterface

  public init(interactor: NowPlayingMovieListInteractorInterface) {
    self.interactor = interactor
  }

  public func fetchNowPlayMovieList() -> AnyPublisher<[Movie], Never> {
    let request = Message.Request()
    return interactor.fetchNowPlayingMovieList(request: request)
      .replaceError(with: .init(movie: []))
      .flatMap(responseProcessor(response:))
      .eraseToAnyPublisher()
  }

  private func responseProcessor(response: Message.Response) -> AnyPublisher<[Movie], Never> {
    return Just(response.movie)
      .eraseToAnyPublisher()
  }
}

extension NowPlayingMovieListUseCase {
  public enum Message {
    public struct Request {

    }

    public struct Response {
      let movie: [Movie]
    }
  }
}
