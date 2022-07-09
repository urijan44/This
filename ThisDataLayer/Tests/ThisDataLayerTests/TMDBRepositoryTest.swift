//
//  TMDBRepositoryTest.swift
//  
//
//  Created by hoseung Lee on 2022/07/09.
//

import XCTest
@testable import ThisDataLayer

final class TMDBRepositoryTest: XCTestCase {

  var sut: TMDBRepositoryInterface!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = TMDBRepository()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testRepository_whenRequest_SuccessCase() {
    let exp = expectation(description: "is result not received")
    sut.fetchSearchResult(text: "토르", language: "ko_KR", region: "KR") { result in

      switch result {
        case .success(let response):
          print(response)
          exp.fulfill()
        case .failure(let error):
          print(error.localizedDescription)
          exp.fulfill()
      }
    }
    waitForExpectations(timeout: 0.5)
  }
}
