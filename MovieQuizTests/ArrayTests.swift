//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Timofey Bulokhov on 23.12.2023.
//

import Foundation

import XCTest
@testable import MovieQuiz


class ArrayTest: XCTestCase {
    
    func testGetValueInRange() throws {
        let array = [1, 1, 2, 3, 5]
        
        let value = array[safe: 2]
        
        XCTAssertEqual(value, 2)
        XCTAssertNotNil(value)
    }
    
    func testGetValueOutOfRange() throws {
        let array = [1, 1, 2, 3, 5]
        
        let value = array[safe: 5]
        
        XCTAssertNil(value)
    }
}
