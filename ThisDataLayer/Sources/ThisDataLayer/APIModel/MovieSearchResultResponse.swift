//
//  MovieSearchResultResponse.swift
//  This
//
//  Created by hoseung Lee on 2022/07/07.
//
import Foundation

// MARK: - MovieSearchResultResponse
public struct MovieSearchResultResponse: Decodable {
  public var page: Int?
  public var results: [SearchResult]?
  public var totalPages: Int?
  public var totalResults: Int?

  enum CodingKeys: String, CodingKey {
    case page = "page"
    case results = "results"
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result
public struct SearchResult: Codable {
  public var adult: Bool?
  public var backdropPath: String?
  public var genreIDS: [Int]?
  public var id: Int?
  public var originalLanguage: String?
  public var originalTitle: String?
  public var overview: String?
  public var popularity: Double?
  public var posterPath: String?
  public var releaseDate: String?
  public var title: String?
  public var video: Bool?
  public var voteAverage: Double?
  public var voteCount: Int?

  enum CodingKeys: String, CodingKey {
    case adult = "adult"
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id = "id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview = "overview"
    case popularity = "popularity"
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title = "title"
    case video = "video"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
