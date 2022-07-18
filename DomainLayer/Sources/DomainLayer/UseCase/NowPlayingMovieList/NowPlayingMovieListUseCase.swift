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
  private var currentPage = 1
  private var totalPage = Int(Int8.max)

  public init(interactor: NowPlayingMovieListInteractorInterface) {
    self.interactor = interactor
  }

  public func fetchNowPlayMovieList() -> AnyPublisher<[Movie], Never> {
    guard currentPage < totalPage else { return Just([]).eraseToAnyPublisher() }
    let request = Message.Request(page: currentPage)
    return interactor.fetchNowPlayingMovieList(request: request)
      .replaceError(with: .init(page: currentPage, totalPage: currentPage, movie: []))
      .flatMap(responseProcessor(response:))
      .eraseToAnyPublisher()
  }

  private func responseProcessor(response: Message.Response) -> AnyPublisher<[Movie], Never> {
    currentPage = response.page + 1
    totalPage = response.totalPage
    return Just(response.movie)
      .eraseToAnyPublisher()
  }
}

extension NowPlayingMovieListUseCase {
  public enum Message {
    public struct Request {
      let page: Int
    }

    public struct Response {
      let page: Int
      let totalPage: Int
      let movie: [Movie]
    }
  }
}
