//
//  TMDBGenre.swift
//  
//
//  Created by hoseung Lee on 2022/07/10.
//

import Foundation

public struct Genre: Decodable {
  public let id: Int
  public let name: String

  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
