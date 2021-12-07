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
    
    mutating func draw() -> (Int, Int, Int, Int) {
        var lastSolved = -1
        var lastMarked = -1
        var firstSolved = -1
        var firstMarked = -1
        var solved : Set<Int> = []

        while index < draws.count {
            let value = draws[index]
            index += 1
            
            // Check each board for the value
            for i in 0..<boards.count {
                if boardSets[i].contains(value) {
                    marked[i].insert(boards[i].firstIndex(of: value)!)
                    if marked[i].count >= 5 {
                        if isSolved(marked[i]) && !solved.contains(i) {
                            if solved.count == 0 {
                                firstSolved = i
                                firstMarked = index
                            }
                            lastSolved = i
                            lastMarked = index
                            solved.insert(i)
                        }
                    }
                }
            }
        }
        return (firstSolved, firstMarked, lastSolved, lastMarked)
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
        
    func score(_ board:Int, lastMarked:Int) -> Int {
        let finalMarked = Set(draws[0..<lastMarked])
        let total = boards[board].enumerated().filter { i, _ in
            return !finalMarked.contains(boards[board][i])
        }.reduce(0) { partialResult, e in
            return partialResult + e.element
        }
        return total * draws[lastMarked-1]
    }
}

class Day4 : Day {
    let day = 4
    typealias T = Game
    
    var (firstSolved, firstMarked, lastSolved, lastMarked) : (Int, Int, Int, Int) = (0,0,0,0)
        
    func run() {
        log("running...")
        let input = try! String(contentsOfFile: "input/\(day)/input")
        var g = Game(input)!
        (firstSolved, firstMarked, lastSolved, lastMarked) = g.draw()
        log("part one: \(partOne([g]))")
        log("part two: \(partTwo([g]))")
        log("done")
    }
    
    @discardableResult func test() -> Bool {
        log("running tests...")

        let folders = try! FileManager.default.contentsOfDirectory(atPath: "tests/\(day)")
    
        var failed = false
        
        folders.forEach { f in
            let folderPath = "tests/\(day)/\(f)/"
            
            let input = try! String(contentsOfFile: folderPath+"input")
            var g = Game(input)!
            (firstSolved, firstMarked, lastSolved, lastMarked) = g.draw()
            
            let answers : [Int] = parseInt(filepath: folderPath+"answer")
            
            let answerOne = partOne([g])
            if answerOne != answers[0] {
                log("test \(f) part 1 FAILED. Expected \(answers[0]), got \(answerOne)")
                failed = true
            }
            if answers.count > 1 {
                let answerTwo = partTwo([g])
                if answerTwo != answers[1] {
                    log("test \(f) part 2 FAILED.  Expected \(answers[1]), got \(answerTwo)")
                    failed = true
                }
            }
        }
        if !failed {
            log("all tests passed")
        } else {
            log("tests complete")
        }
        return true
    }

    
    func partOne(_ input: [Game]) -> Int {
        return input[0].score(firstSolved, lastMarked: firstMarked)
    }
    
    func partTwo(_ input: [Game]) -> Int {
        return input[0].score(lastSolved, lastMarked: lastMarked)
    }
    
}
