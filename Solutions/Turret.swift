//
//  Turret.swift
//  baekjoon-algorithm
//
//  Created by 민경준 on 2/26/25.
//
// https://st-lab.tistory.com/90

import Foundation

func solution(_ splited: [Int]) -> Int {
    let x1 = splited[0]
    let y1 = splited[1]
    let r1 = splited[2]
    
    let x2 = splited[3]
    let y2 = splited[4]
    let r2 = splited[5]
    
    let dx = Double(x2 - x1)
    let dy = Double(y2 - y1)
    let distance = (dx * dx) + (dy * dy)
    
    let sum = Double(r1 + r2)
    let minus = Double(r2 - r1)
    
    // case 1 : 중점이 같으면서 반지름도 같을 경우
    if(x1 == x2 && y1 == y2 && r1 == r2) {
        return -1
    }
    // case 2-1: 두 원의 반지름 합보다 중점간 거리가 더 길 때
    else if (distance > pow(sum, 2)) {
        return 0
    }
    // case 2-2: 원 안에 원이 있으나 내접하지 않을 때
    else if (distance < pow(minus, 2)) {
        return 0
    }
    // case 3-1: 내접할 때
    else if (distance == pow(minus, 2)) {
        return 1
    }
    // case 3-2: 외접할 때
    else if (distance == pow(sum, 2)) {
        return 1
    }
    else {
        return 2
    }
}


let count: Int = Int(readLine()!)!
for _ in 0 ..< count {
    let splited = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
    
    let result = solution(splited)
    print(result)
}
