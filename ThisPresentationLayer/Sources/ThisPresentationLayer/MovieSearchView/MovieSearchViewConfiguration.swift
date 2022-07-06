//
//  MovieSearchViewConfiguration.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import SwiftUI
import Combine
import DomainLayer

extension MovieSearchView {
  struct ViewModel: MovieSearchViewItemInterface, Equatable, Transferable {
    static var transferRepresentation: some TransferRepresentation {
      ProxyRepresentation(exporting: \.title)
    }
    var id: String
    var title: String
    var releaseDateString: String
    var genreString: String
    var castingString: String
    var bookmarked: Bool
    var imageURLString: String

    init(id: String = UUID().uuidString, title: String, releaseDateString: String, genreString: String, castingString: String, bookmarked: Bool, imageURLString: String) {
      self.id = id
      self.title = title
      self.releaseDateString = releaseDateString
      self.genreString = genreString
      self.castingString = castingString
      self.bookmarked = bookmarked
      self.imageURLString = imageURLString
    }

    init(movie: Movie) {
      self.id = movie.id
      self.title = movie.title
      self.bookmarked = movie.boomarked
      self.imageURLString = movie.imageURLString
      self.releaseDateString = ""
      self.genreString = ""
      self.castingString = ""
      self.releaseDateString = dateToString(date: movie.releaseDate)
      self.genreString = genreCombineer(genres: movie.genre)
      self.castingString = castingCombiner(casting: movie.casting)
    }

    private func dateToString(date: Date) -> String {
      date.toString()
    }

    private func genreCombineer(genres: [String]) -> String {
      genres.joined(separator: ", ")
    }

    private func castingCombiner(casting: [String]) -> String {
      casting.joined(separator: ", ")
    }
  }

  public final class Configuration: ObservableObject {
    @Published var searchText = ""
    let item = PassthroughSubject<MovieSearchViewItemInterface, Never>()
    private let useCase: MovieSearchUseCaseInterface
    private var cancellables: Set<AnyCancellable> = []
    public init(useCase: MovieSearchUseCaseInterface) {
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
        .compactMap { movie in
          return ViewModel(movie: movie)
        }
        .eraseToAnyPublisher()
    }
  }
}

extension Date {
  func toString(format: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
}
