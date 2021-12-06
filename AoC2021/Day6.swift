//
//  Day6.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/06.
//

import Foundation

struct Day6 : Day {
    typealias T = Int
    let day = 6
    
    func parse(filepath: String) -> [Int] {
        var populations = Array(repeating: 0, count: 9)
        let input = try! String(contentsOfFile: filepath)
        input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .punctuationCharacters).compactMap(Int.init).forEach({populations[$0+1] += 1})
        
        return populations
    }
    
    func step(_ input:[Int]) -> [Int] {
        var populations = input
        let temp = populations[0]
        populations[0] = populations[1]
        populations[1] = populations[2]
        populations[2] = populations[3]
        populations[3] = populations[4]
        populations[4] = populations[5]
        populations[5] = populations[6]
        populations[6] = populations[7] + temp
        populations[7] = populations[8]
        populations[8] = temp
        
        return populations
    }
    
    func partOne(_ input: [Int]) -> Int {
        let days = 80
        var input = input
        for _ in 0...days {
            input = step(input)
        }
        return input.reduce(0, +)
    }
    
    func partTwo(_ input: [Int]) -> Int {
        let days = 256
        var input = input
        for _ in 0...days {
            input = step(input)
        }
        
        return input.reduce(0, +)
    }
}
