//
//  LittlePrince.swift
//  baekjoon-algorithm
//
//  Created by 민경준 on 2/26/25.
//
// https://cocoon1787.tistory.com/350

import Foundation

let count: Int = Int(readLine()!)!

protocol Coordinate {
    var x: Double { get set }
    var y: Double { get set }
}

struct Circle: Coordinate {
    var x: Double
    var y: Double
    var radius: Double
    
    func inside(_ point: Coordinate) -> Bool {
        // 두 점 사이의 거리 계산
        let dx = pow(point.x - x, 2)
        let dy = pow(point.y - y, 2)
        let distance = sqrt(dx + dy)
        
        // 거리가 반지름보다 작거나 같으면 원 안에 있음
        return distance <= radius
    }
}

struct Point: Coordinate {
    var x: Double
    var y: Double
}

for _ in 0 ..< count {
    let pointValues = readLine()!.split(separator: " ").compactMap { Double(String($0)) }

    // 출발 지점과 도착 지점
    let start = Point(x: pointValues[0], y: pointValues[1])
    let end = Point(x: pointValues[2], y: pointValues[3])
    
    var result: Int = 0
    let circleCount: Int = Int(readLine()!)!
    for _ in 0 ..< circleCount {
        let circleValues = readLine()!.split(separator: " ").compactMap { Double(String($0)) }
        let circle: Circle = .init(
            x: circleValues[0],
            y: circleValues[1],
            radius: circleValues[2]
        )

        // 원 안에 출발 지점과 도착 지점 둘 다 있으면 그냥 넘어감.
        if circle.inside(start) && circle.inside(end) {
            continue
        } else
        // 출발 지점을 포함하여 이탈이 필요하므로 결과 +1
        if circle.inside(start) {
            result += 1
        } else
        // 도착 지점을 포함하여 진입이 필요하므로 결과 +1
        if circle.inside(end) {
            result += 1
        }
    }
    
    print(result)
}
