//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Timofey Bulokhov on 23.12.2023.
//

import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        let array = [1,1,2,3,5]
        let value = array[safe: 2]
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    
    func testGetValueOutRange() throws {
        let array = [1, 1, 2, 3, 5]
        let value = array[safe: 20]
        XCTAssertNil(value)
    }
                  
}
