//
//  MovieSearchUseCaseInterface.swift
//  
//
//  Created by hoseung Lee on 2022/07/07.
//

import Foundation
import Combine 
public protocol MovieSearchUseCaseInterface {
  func fetchSearcResult(searchText: String) -> AnyPublisher<Movie, Never>
}
