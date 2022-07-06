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
  public let genre: [String]
  public let casting: [String]
  public var boomarked: Bool
  public let imageURLString: String

  public init(id: String, title: String, releaseDate: Date, genre: [String], casting: [String], boomarked: Bool, imageURLString: String) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.genre = genre
    self.casting = casting
    self.boomarked = boomarked
    self.imageURLString = imageURLString
  }
}
