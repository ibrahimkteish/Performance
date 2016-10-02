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

    func withUnsafeBufferPointerIndexes_numberOfVowels(in string:String) -> Int {
        
        var numberOfVowels = 0
        
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        
        vowels.withUnsafeBufferPointer { bufferPointer  in
            
            for char in string.characters {
                
                for index in bufferPointer.startIndex..<bufferPointer.endIndex {
                    
                    if bufferPointer[index] == char {
                        
                        numberOfVowels += 1
                    }
                }
            }
        }
        
        return numberOfVowels
    }
    
    
    func withUnsafeBufferPointerBothIndexes_numberOfVowels(in characters:[Character]) -> Int {
        
        var numberOfVowels = 0
        
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

        vowels.withUnsafeBufferPointer { vowelsBufferPointer  in

            characters.withUnsafeBufferPointer { charactersBuffer in
            
                for idx in charactersBuffer.startIndex..<charactersBuffer.endIndex {
        
                    for index in vowelsBufferPointer.startIndex..<vowelsBufferPointer.endIndex {
                    
                        if vowelsBufferPointer[index] == charactersBuffer[idx] {
                            
                            numberOfVowels += 1
                        }
                    }
                }
            }
        }
        
        return numberOfVowels
    }
    
    
    func concurrentChunked_numberOfVowelsInString(chunks: ChunkSequence<String.CharacterView> , callback: @escaping (Int) -> Void) {
        
        var numberOfVowels = 0
        
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
    
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        for chunk in chunks {
            
            queue.async(group: group, execute: {
                
                vowels.withUnsafeBufferPointer { vowelsBufferPointer  in
                    
                    chunk.withUnsafeBufferPointer { charactersBuffer in
                        
                        for idx in charactersBuffer.startIndex..<charactersBuffer.endIndex {
                            
                            for index in vowelsBufferPointer.startIndex..<vowelsBufferPointer.endIndex {
                                
                                if vowelsBufferPointer[index] == charactersBuffer[idx] {
                                    
                                    numberOfVowels += 1
                                }
                            }
                        }
                    }
                }
            })
        }
        
        group.notify(queue: queue) {
            
            callback(numberOfVowels)
        }
    }
}

//http://stackoverflow.com/questions/31185492/split-large-array-in-array-of-two-elements
struct ChunkIterator<I : IteratorProtocol> : IteratorProtocol {
    
    private var _iterator: I
    private let chunk: Int
    private var chunked: [I.Element]
    
    internal mutating func next() -> [I.Element]? {
        var i = chunk
        
        return _iterator.next().map {
            
            chunked = [$0]
            
            while i > 0, let next = _iterator.next() {
                
                chunked.append(next)
                
                i -= 1
            }
            
            return chunked
        }
    }
    
    fileprivate init(iterator: I, chunk: Int) {
        
        self._iterator = iterator
        self.chunk = chunk
        self.chunked = []
        self.chunked.reserveCapacity(chunk)
    }
}

struct ChunkSequence<S : Sequence> : Sequence  {
    
    fileprivate let sequence: S
    fileprivate let chunk: Int
    
    internal func makeIterator() -> ChunkIterator<S.Iterator> {
        return ChunkIterator(iterator: sequence.makeIterator(), chunk: chunk)
    }
}

extension Sequence {
    func chunk(by value: Int) -> ChunkSequence<Self> {
        
        return ChunkSequence(sequence: self, chunk: value)
    }
}



