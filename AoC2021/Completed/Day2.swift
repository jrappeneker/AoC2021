//
//  Day2.swift
//  AoC2021
//
//  Created by Joshua Rappeneker on 2021/12/02.
//

enum Direction : String {
    case forward
    case down
    case up
}

struct Command : StringInitializable {
    init?(_ s: String) {
        let parts = s.components(separatedBy: .whitespaces)
        guard let distance = Int(parts[1]), let direction = Direction(rawValue: parts[0]) else {
            return nil
        }
        
        self.distance = distance
        self.direction = direction
    }
    
    let direction : Direction
    let distance : Int
}

struct Day2 : Day {
    typealias T = Command
    let day = 2
            
    func partOne(_ input:[Command]) -> Int {
        var depth = 0
        var position = 0
        for c in input {
            switch c.direction {
            case .forward:
                position += c.distance
            case .down:
                depth += c.distance
            case .up:
                depth -= c.distance
            }
        }

        return depth*position
    }
    
    func partTwo(_ input:[Command]) -> Int {
        var depth = 0
        var position = 0
        var aim = 0
        
        for c in input {
            switch c.direction {
            case .forward:
                position += c.distance
                depth += aim*c.distance
            case .down:
                aim += c.distance
            case .up:
                aim -= c.distance
            }
        }

        return depth*position
    }
}
