//
//  Day5.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/06.
//

import Foundation

struct Day5 : Day {
    struct Point : StringInitializable, Hashable {
        let x : Int
        let y : Int
        
        init?(_ s: String) {
            let parts = s.components(separatedBy: .punctuationCharacters)
            guard let x = Int(parts[0]), let y = Int(parts[1]) else {
                return nil
            }
            self.x = x
            self.y = y
        }
        
        init(_ x:Int, _ y:Int) {
            self.x = x
            self.y = y
        }
    }

    struct Line : StringInitializable {
        let start : Point
        let end : Point
        
        init?(_ s: String) {
            let parts = s.components(separatedBy: " -> ")
            guard let start = Point(parts[0]), let end = Point(parts[1]) else {
                return nil
            }
            self.start = start
            self.end = end
        }
    }

    typealias T = Line
    let day = 5
    
    func partOne(_ input: [Line]) -> Int {
        var vents : [Point:Int] = [:]
        
        for line in input {
            if line.start.x == line.end.x {
                let starty = min(line.start.y, line.end.y)
                let endy = max(line.start.y, line.end.y)
                
                for i in starty...endy {
                    vents[Point(line.start.x, i), default: 0] += 1
                }
            } else if line.start.y == line.end.y {
                let startx = min(line.start.x, line.end.x)
                let endx = max(line.start.x, line.end.x)
                
                for i in startx...endx {
                    vents[Point(i, line.start.y), default: 0] += 1
                }
            }
        }

        return vents.filter({$0.value > 1}).count
    }
    
    func partTwo(_ input: [Line]) -> Int {
        var vents : [Point:Int] = [:]
        
        for line in input {
            let starty = min(line.start.y, line.end.y)
            let endy = max(line.start.y, line.end.y)
            let startx = min(line.start.x, line.end.x)
            let endx = max(line.start.x, line.end.x)
                        
            if line.start.x == line.end.x {
                for i in starty...endy {
                    vents[Point(line.start.x, i), default: 0] += 1
                }
            } else if line.start.y == line.end.y {
                for i in startx...endx {
                    vents[Point(i, line.start.y), default: 0] += 1
                }
            } else {
                let deltax = (line.end.x - line.start.x) > 0 ? 1 : -1
                let deltay = (line.end.y - line.start.y) > 0 ? 1 : -1
                let xIndexes = stride(from: line.start.x, to: line.end.x+deltax, by: deltax)
                let yIndexes = stride(from: line.start.y, to: line.end.y+deltay, by: deltay)

                let points = zip(xIndexes, yIndexes)
                points.forEach { (x, y) in
                    vents[Point(x, y), default: 0] += 1
                }
            }
            
        }
        return vents.filter({$0.value > 1}).count
    }
}
