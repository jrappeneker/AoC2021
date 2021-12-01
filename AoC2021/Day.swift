//
//  Day.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/02.
//

import Foundation

protocol Day {
    associatedtype T : StringInitializable
    
    var day : Int { get }
    func parse(filepath:String) -> [T]
    func parseInt(filepath:String) -> [Int]
    func run()
    func partOne(_ input:[T]) -> Int
    func partTwo(_ input:[T]) -> Int
    @discardableResult func test() -> Bool
    func log(_ message:String)
}

extension Day {
    func log(_ message:String) {
        print("day \(day):", message)
    }
    
    func parseInt(filepath:String) -> [Int] {
        let input = try! String(contentsOfFile: filepath)
        return input.components(separatedBy: .newlines).compactMap(Int.init)
    }
    
    func parse(filepath:String) -> [T] {
        let input = try! String(contentsOfFile: filepath)
        return input.components(separatedBy: .newlines).compactMap(T.init)
    }
    
    @discardableResult func test() -> Bool {
        log("running tests...")

        let folders = try! FileManager.default.contentsOfDirectory(atPath: "tests/\(day)")
    
        var failed = false
        
        folders.forEach { f in
            let folderPath = "tests/\(day)/\(f)/"
            
            let input : [T] = parse(filepath: folderPath+"input")
            let answers : [Int] = parseInt(filepath: folderPath+"answer")
            
            if partOne(input) != answers[0] {
                log("test \(f) part 1 FAILED")
                failed = true
            } else if answers.count > 1 && partTwo(input) != answers[1] {
                log("test \(f) part 2 FAILED")
                failed = true
            }
            
        }
        if !failed {
            log("all tests passed")
        } else {
            log("tests complete")
        }
        return true
    }

    func run() {
        log("running...")
        let input : [T] = parse(filepath: "input/\(day)/input")
        log("part one: \(partOne(input))")
        log("part two: \(partTwo(input))")
        log("done")
    }
}

protocol StringInitializable {
    init?(_ s:String)
}

extension Int : StringInitializable {}
