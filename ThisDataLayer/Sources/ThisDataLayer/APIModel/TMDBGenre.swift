// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieSearchResultResponse = try? newJSONDecoder().decode(MovieSearchResultResponse.self, from: jsonData)

import Foundation

// MARK: - GenreResponse
struct GenreResponse: Codable {
  var genres: [Genre]?

  enum CodingKeys: String, CodingKey {
    case genres = "genres"
  }
}

// MARK: - Genre
struct Genre: Codable {
  var id: Int?
  var name: String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
  }
}
