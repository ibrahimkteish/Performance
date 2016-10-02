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
    
    func testPerformanceFastEnumeration() {
        // This is an example of a performance test case.
        self.measure { [weak self] in
        
            for _ in 0...1000 {
                
                _ = self?.viewController.numberOfVowels(in: self?.string ?? "")
            }
        }
    }
    
    func testPerformanceReduce() {
        // This is an example of a performance test case.
        self.measure { [weak self] in
            
            for _ in 0...1000 {
                
                _ = self?.viewController.reduce_numberOfVowels(in: self?.string ?? "")
            }
        }
    }
    
    func testPerformanceFastEnumerationWithWhere() {
        // This is an example of a performance test case.
        self.measure { [weak self] in
            
            for _ in 0...1000 {
                
                _ = self?.viewController.fastEnumerationWithWhere_numberOfVowels(in: self?.string ?? "")
            }
        }
    }
}
