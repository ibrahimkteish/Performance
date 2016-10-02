//
//  PerformanceTests.swift
//  PerformanceTests
//
//  Created by Ibrahim Kteish on 10/2/16.
//  Copyright © 2016 Ibrahim Kteish. All rights reserved.
//

import XCTest
@testable import Performance

class PerformanceTests: XCTestCase {
    
    let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    let viewController = ViewController()
    
    func testReduce() {
        
        let numberOfVowels = viewController.reduce_numberOfVowels(in: string)
        
        XCTAssertEqual(numberOfVowels, 167, "should find 167 vowels")
    }
    
    func testFastEnumeration() {
        
        let numberOfVowels = viewController.numberOfVowels(in: string)
        
        XCTAssertEqual(numberOfVowels, 167, "should find 167 vowels")
        
    }
    
    func testWithUnsafeBufferPointer() {
        
        let numberOfVowels = viewController.withUnsafeBufferPointer_numberOfVowels(in: string)
        
        XCTAssertEqual(numberOfVowels, 167, "should find 167 vowels")
        
    }
    
    func testWithUnsafeBufferPointerIndexes() {
        
        let numberOfVowels = viewController.withUnsafeBufferPointerIndexes_numberOfVowels(in: string)
        
        XCTAssertEqual(numberOfVowels, 167, "should find 167 vowels")
        
    }
    
    func testWithUnsafeBufferPointerBothIndexes() {

        let characters: [Character] = Array(string.characters)
        let numberOfVowels = viewController.withUnsafeBufferPointerBothIndexes_numberOfVowels(in: characters)
        
        XCTAssertEqual(numberOfVowels, 167, "should find 167 vowels")
        
    }
    
    func testConcurrentChunked() {
        
        let chunks = string.characters.chunk(by:150)

        viewController.concurrentChunked_numberOfVowelsInString(chunks: chunks) { (numberOfVowels) in
            
            XCTAssertEqual(numberOfVowels, 167, "should find 167 vowels")
        }
    }
    
    func testPerformanceFastEnumeration() {

        self.measure { [weak self] in
        
            for _ in 0...1000 {
                
                _ = self?.viewController.numberOfVowels(in: self?.string ?? "")
            }
        }
    }
    
    func testPerformanceReduce() {

        self.measure { [weak self] in
            
            for _ in 0...1000 {
                
                _ = self?.viewController.reduce_numberOfVowels(in: self?.string ?? "")
            }
        }
    }
    
    func testPerformanceFastEnumerationWithWhere() {

        self.measure { [weak self] in
            
            for _ in 0...1000 {
                
                _ = self?.viewController.fastEnumerationWithWhere_numberOfVowels(in: self?.string ?? "")
            }
        }
    }

    func testPerformanceWithUnsafeBufferPointer() {

        self.measure { [weak self] in
            
            for _ in 0...1000 {
                
                _ = self?.viewController.withUnsafeBufferPointer_numberOfVowels(in: self?.string ?? "")
            }
        }
    }
    
    
    func testPerformanceWithUnsafeBufferPointerIndexes() {

        self.measure { [weak self] in
            
            for _ in 0...1000 {
                
                _ = self?.viewController.withUnsafeBufferPointerIndexes_numberOfVowels(in: self?.string ?? "")
            }
        }
    }
    
    func testPerformanceWithUnsafeBufferPointerBothIndexes() {

        self.measure { [weak self] in
            
            let characters: [Character] = Array(self!.string.characters)
            for _ in 0...1000 {
                
                _ = self?.viewController.withUnsafeBufferPointerBothIndexes_numberOfVowels(in: characters )
            }
        }
    }
    
    
    func testPerformanceConcurrentChunked() {

        self.measure { [weak self] in
            
            
            let chunks = self!.string.characters.chunk(by:150)
            
            for _ in 0...1000 {
                self?.viewController.concurrentChunked_numberOfVowelsInString(chunks: chunks) { _ in }
            }
        }
    }
}
