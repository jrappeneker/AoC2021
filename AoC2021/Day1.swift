//
//  Day1.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/02.
//

import Foundation

struct Day1 : Day {
    typealias T = Int
    let day = 1
        
    func partOne(_ input:[Int]) -> Int {
        var current = input[0]
        var count = 0
        for n in input {
            if n > current {
                count += 1
            }
            current = n
        }
        return count
    }
    
    
    func partTwo(_ input:[Int]) -> Int {
        var count = 0
        var current = input[0..<3].reduce(0, +)
        for i in 3..<input.count {
            let sum = input[i-2...i].reduce(0, +)
            if sum > current {
                count += 1
            }
            current = sum
        }
        return count
    }
        
    func run() {
        log("running...")
        let input : [Int] = parse(filepath: "input/\(day)/input")
        log("part one: \(partOne(input))")
        log("part two: \(partTwo(input))")
        log("done")
    }
}
