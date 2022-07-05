//
//  MovieSearchViewConfiguration.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import SwiftUI
import Combine

extension MovieSearchView {
  struct ViewModel: MovieSearchViewItemInterface, Equatable, Transferable {
    static var transferRepresentation: some TransferRepresentation {
      ProxyRepresentation(exporting: \.title)
    }
    var title: String
    var releaseDate: String
    var genre: String
    var casting: String
    var bookmarked: Bool
    var imageURLString: String
  }

  final class Configuration: ObservableObject {
    @Published var searchText = ""
    let item = PassthroughSubject<MovieSearchViewItemInterface, Never>()
    private let useCase: MovieSearchUseCaseInterface
    private var cancellables: Set<AnyCancellable> = []
    init(useCase: MovieSearchUseCaseInterface) {
      self.useCase = useCase

      $searchText
        .debounce(for: 1, scheduler: DispatchQueue.main)
        .removeDuplicates()
        .flatMap({ [unowned self] searchText in
          fetchSearcResult(searchText: searchText)
        })
        .sink(receiveValue: { [unowned self] item in
          self.item.send(item)
        })
        .store(in: &cancellables)
    }

    private func fetchSearcResult(searchText: String) -> AnyPublisher<MovieSearchViewItemInterface, Never> {
      useCase.fetchSearcResult(searchText: searchText)
    }
  }
}
