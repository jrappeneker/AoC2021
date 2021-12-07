//
//  Day7.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/06.
//

import Foundation

struct Day7 : Day {
    let day = 7
    typealias T = Int
    
    func parse(filepath: String) -> [Int] {
        let input = try! String(contentsOfFile: filepath)
        return input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .punctuationCharacters).compactMap(Int.init)
    }
    
    func moveCrabs(`in` input:[Int], to alignment:Int, using calculateFuel:(Int, Int)->Int = {abs($0-$1)}) -> Int {
        return input.reduce(0) { partialResult, position in
            return partialResult + calculateFuel(alignment, position)
        }
    }
        
    func partOne(_ input: [Int]) -> Int {
        let minDistance = (0...input.max()!).map { alignment in
            return moveCrabs(in: input, to: alignment)
        }.enumerated().min { a, b in
            return a.1 < b.1
        }
        
        return minDistance!.1
    }
    
    func partTwo(_ input: [Int]) -> Int {
        let minDistance = (0...input.max()!).map { alignment in
            return moveCrabs(in: input, to: alignment) { alignment, position in
                let length = abs(alignment - position)
                return length*(length + 1)/2
            }
        }.enumerated().min { a, b in
            return a.1 < b.1
        }

        return minDistance!.1
    }
}
