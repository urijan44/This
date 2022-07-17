//
//  Movie.swift
//  This
//
//  Created by hoseung Lee on 2022/07/07.
//

import Foundation

public struct Movie {
  public let id: String
  public let title: String
  public let releaseDate: Date
  public let genre: [Genre]
  public let casting: [String]
  public var boomarked: Bool
  public let imageURLString: String
  public let overview: String
  public let voteRate: String
  public let originalTitle: String
  public let localTitle: String

  public init(id: String, title: String, releaseDate: Date, genre: [Genre], casting: [String], boomarked: Bool, imageURLString: String, overview: String, voteRate: String, originalTitle: String, localTitle: String) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.genre = genre
    self.casting = casting
    self.boomarked = boomarked
    self.imageURLString = imageURLString
    self.overview = overview
    self.voteRate = voteRate
    self.originalTitle = originalTitle
    self.localTitle = localTitle
  }
}

extension Movie {
  static func noResult(searchText: String) -> Movie {
    return Movie(
      id: "",
      title: "\(searchText)의 검색결과를 찾을 수 없습니다.",
      releaseDate: Date(),
      genre: [],
      casting: [],
      boomarked: false,
      imageURLString: "",
      overview: "",
      voteRate: "",
      originalTitle: "",
      localTitle: "")
  }
}
