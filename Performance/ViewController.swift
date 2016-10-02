//
//  ViewController.swift
//  Performance
//
//  Created by Ibrahim Kteish on 10/2/16.
//  Copyright © 2016 Ibrahim Kteish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: To be tested
    
    func numberOfVowels(in string:String) -> Int {
        
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        
        var numberOfVowels = 0
        
        for character in string.characters {
            if vowels.contains(character) {
                numberOfVowels += 1
            }
        }
        
        return numberOfVowels
    }
    
    
    func reduce_numberOfVowels(in string:String) -> Int {
        
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        
        return string.characters.reduce(0) { $0 + (vowels.contains($1) ? 1 : 0) }
    }

    
    func fastEnumerationWithWhere_numberOfVowels(in string:String) -> Int {
        
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        
        var numberOfVowels = 0
        
        for character in string.characters where vowels.contains(character) {
        
            numberOfVowels += 1
        }
        
        return numberOfVowels
    }
    
    func withUnsafeBufferPointer_numberOfVowels(in string:String) -> Int {
        
        var numberOfVowels = 0
        
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        
        vowels.withUnsafeBufferPointer { bufferPointer  in
            
            for char in string.characters {
                
                for aCharacter in bufferPointer {
                    
                    if aCharacter == char {
                        
                        numberOfVowels += 1
                    }
                }
            }
        }
        
        return numberOfVowels
    }
}

