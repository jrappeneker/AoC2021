//
//  main.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/01.
//

import Foundation

let input =
"""
1
2
3
"""

let numbers = input.components(separatedBy: .newlines).compactMap(Int.init)

var current = numbers[0]
var count = 0
for n in numbers {
    if n > current {
        count += 1
    }
    current = n
}


print(count)

count = 0
current = numbers[0..<3].reduce(0, +)
for i in 3..<numbers.count {
    let sum = numbers[i-2...i].reduce(0, +)
    if sum > current {
        count += 1
    }
    current = sum
}

print(count)
