//
//  NowPlayingMovieListViewConfiguration.swift
//  
//
//  Created by hoseung Lee on 2022/07/18.
//

import Combine

extension NowPlayingMovieListView {
  enum Action {
    case viewDidLoad
  }

  final class Configuration: ObservableObject {

    let action = PassthroughSubject<Action, Never>()

    private var cancellables = Set<AnyCancellable>()

    init() {
      action
        .sink { [unowned self] action in
          switch action {
            case .viewDidLoad:
              fetchMovieList()
          }
        }
        .store(in: &cancellables)
    }

    private func fetchMovieList() {

    }
  }
}
