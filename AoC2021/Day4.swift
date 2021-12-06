//
//  Day4.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/06.
//

import Foundation

struct Game : StringInitializable {
    let draws : [Int]
    let boards : [[Int]]
    let boardSets : [Set<Int>]
    var marked : [Set<Int>]
    var index = 0
    
    init?(_ s: String) {
        let rows = s.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        draws = rows[0].components(separatedBy: .punctuationCharacters).compactMap(Int.init)
        var index = 1
        var allBoards = [[Int]]()
        var tempBoardSets : [Set<Int>] = []
        
        while index < rows.count {
            var board = [Int]()
            for i in 0...5 {
                board.append(contentsOf: rows[index+i].components(separatedBy: .whitespaces).compactMap(Int.init))
            }
            allBoards.append(board)
            tempBoardSets.append(Set(board))
            index += 6
        }
        marked = Array(repeating: [], count: allBoards.count)
        boards = allBoards
        boardSets = tempBoardSets
    }
    
    mutating func drawNext() -> Int {
        while index < draws.count {
            let value = draws[index]
            index += 1
            
            // Check each board for the value
            for i in 0..<boards.count {
                if boardSets[i].contains(value) {
                    marked[i].insert(boards[i].firstIndex(of: value)!)
                    if marked[i].count >= 5 {
                        if isSolved(marked[i]) {
                            return i
                        }
                    }
                }
            }
        }
        return -1
    }
    
    mutating func drawLast() -> (Int, Int) {
        var lastSolved = -1
        var lastMarked = -1
        var solved : Set<Int> = []
        marked = Array(repeating: [], count: boards.count)
        index = 0
        
        while index < draws.count {
            let value = draws[index]
            index += 1
            
            // Check each board for the value
            for i in 0..<boards.count {
                if boardSets[i].contains(value) {
                    marked[i].insert(boards[i].firstIndex(of: value)!)
                    if marked[i].count >= 5 {
                        if isSolved(marked[i]) && !solved.contains(i) {
                            lastSolved = i
                            lastMarked = index
                            solved.insert(i)
                        }
                    }
                }
            }
        }
        return (lastSolved, lastMarked)
    }
    
    let allRows = stride(from: 0, to: 5, by: 1).map { i in
        return Set(stride(from: i*5, to: i*5+5, by: 1))
    }
    let allColumns = stride(from: 0, to: 5, by: 1).map{ i in
        return Set(stride(from: i, to: i+21, by: 5))
    }
    
    func isSolved(_ board:Set<Int>)->Bool {
        for row in allRows {
            if row.isSubset(of: board) {
                return true
            }
        }
        for column in allColumns {
            if column.isSubset(of: board) {
                return true
            }
        }
        
        return false
    }
    
    func score(_ board:Int) -> Int {
        let total = boards[board].enumerated().filter { i, _ in
            return !marked[board].contains(i)
        }.reduce(0) { partialResult, e in
            return partialResult + e.element
        }
        
        return total * draws[index-1]
    }
    
    func scoreLast(_ board:Int, lastMarked:Int) -> Int {
        let finalMarked = Set(draws[0..<lastMarked])
        let total = boards[board].enumerated().filter { i, _ in
            return !finalMarked.contains(boards[board][i])
        }.reduce(0) { partialResult, e in
            return partialResult + e.element
        }
        return total * draws[lastMarked-1]
    }
}

struct Day4 : Day {
    let day = 4
    typealias T = Game
    
    func parse(filepath: String) -> [Game] {
        let input = try! String(contentsOfFile: filepath)
        return [Game(input)!]
    }
    
    func partOne(_ input: [Game]) -> Int {
        var g = input[0]
        let board = g.drawNext()
        
        return g.score(board)
    }
    
    func partTwo(_ input: [Game]) -> Int {
        var g = input[0]
        let board = g.drawLast()
        return g.scoreLast(board.0, lastMarked:board.1)
    }
    
}
