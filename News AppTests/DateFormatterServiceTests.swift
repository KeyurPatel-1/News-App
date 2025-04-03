//
//  DateFormatterServiceTests.swift
//  News App
//
//  Created by Keyur Patel on 03/04/25.
//

import XCTest
@testable import News_App

final class DateFormatterServiceTests: XCTestCase {

    var dateFormatterService: DateFormatterService!

    override func setUp() {
        super.setUp()
        dateFormatterService = DateFormatterService.shared
    }

    override func tearDown() {
        dateFormatterService = nil
        super.tearDown()
    }

    func testValidDateFormatting() {
        // Arrange
        let inputDate = "2024-04-03T14:30:00Z"
        let expectedOutput = "Apr 3, 2024"

        // Act
        let formattedDate = dateFormatterService.format(inputDate, format: .MMMDYYYY)

        // Assert
        XCTAssertEqual(formattedDate, expectedOutput, "Formatted date should be 'Apr 3, 2024'")
    }

    func testInvalidDateString() {
        // Arrange
        let invalidDateString = "invalid-date"

        // Act
        let formattedDate = dateFormatterService.format(invalidDateString)

        // Assert
        XCTAssertNil(formattedDate, "Formatting an invalid date should return nil")
    }

    func testNilDateString() {
        // Arrange
        let nilDateString: String? = nil

        // Act
        let formattedDate = dateFormatterService.format(nilDateString)

        // Assert
        XCTAssertNil(formattedDate, "Formatting a nil date should return nil")
    }

    func testDifferentDateFormat() {
        // Arrange
        let inputDate = "2024-04-03T14:30:00Z"
        let expectedOutput = "Apr 3, 2024" // Adjust based on format

        // Act
        let formattedDate = dateFormatterService.format(inputDate, format: .MMMDYYYY)

        // Assert
        XCTAssertEqual(formattedDate, expectedOutput, "Formatted date should match the expected output")
    }
}
