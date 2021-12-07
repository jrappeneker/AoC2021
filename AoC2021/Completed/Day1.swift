//
//  Day1.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/02.
//

struct Day1 : Day {
    typealias T = Int
    let day = 1
    
    func findPositiveChanges(_ input:[Int], window:Int) -> Int {
        var count = 0
        for i in window..<input.count {
            if input[i] > input[i-window] {
                count += 1
            }
        }
        return count
    }
        
    func partOne(_ input:[Int]) -> Int {
        return findPositiveChanges(input, window:1)
    }
    
    func partTwo(_ input:[Int]) -> Int {
        return findPositiveChanges(input, window: 3)
    }
}
