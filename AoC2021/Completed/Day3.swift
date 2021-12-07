//
//  day3.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/05.
//

import Foundation

struct Day3 : Day {
    var day: Int = 3
    typealias T = Int
    
    func parse(filepath:String) -> [T] {
        let input = try! String(contentsOfFile: filepath)
        return input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).compactMap { row in
            Int(row, radix: 2)
        }
    }
    
    func partOne(_ input: [Int]) -> Int {
        var counts = [0,0,0,0,0,0,0,0,0,0,0,0]
        for row in input {
            var flag = 0b100000000000
            for i in 0..<counts.count {
                counts[i] += row & flag > 0 ? 1 : 0
                flag = flag >> 1
            }
        }
        var gamma : UInt16 = 0
        
        for c in counts {
            if c > input.count / 2 {
                gamma |= 1
            }
            gamma = gamma << 1
        }
        
        gamma = gamma >> 1
        let epsilon : UInt16 = ~(0b1111000000000000 | gamma)
        
        return Int(gamma)*Int(epsilon)
    }
    
    func findCandidate(_ input: [Int], comparator:(Int, Int)->Bool) -> Int {
        var candidates = input
        var flag = 0b100000000000
        var ones = [Int]()
        var zeros = [Int]()

        while candidates.count > 1 {
            for input in candidates {
                if (input & flag) > 0 {
                    ones.append(input)
                } else {
                    zeros.append(input)
                }
            }
            if comparator(ones.count, zeros.count) {
                candidates = ones
            } else {
                candidates = zeros
            }
            ones = []
            zeros = []
            flag = flag >> 1
        }
        
        return candidates[0]
    }
    
    func partTwo(_ input: [Int]) -> Int {
        let oxy = findCandidate(input, comparator: >=)
        let co2 = findCandidate(input, comparator: <)
        
        return oxy*co2
    }
}
