//
//  MovieSearchItemInterface.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation
protocol MovieSearchViewItemInterface {
  var id: String { get }
  var title: String { get }
  var releaseDateString: String { get }
  var genreString: String { get }
  var castingString: String { get }
  var bookmarked: Bool { get set }
  var imageURLString: String { get }
}
