//
//  MovieSearchItemInterface.swift
//  This
//
//  Created by hoseung Lee on 2022/07/06.
//

import Foundation
protocol MovieSearchViewItemInterface {
  var title: String { get }
  var releaseDate: String { get }
  var genre: String { get }
  var casting: String { get }
  var bookmarked: Bool { get set }
  var imageURLString: String { get }
}
