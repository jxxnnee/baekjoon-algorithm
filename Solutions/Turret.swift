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
    // 무한대에 수렴하기 때문에 -1을 리턴한다.
    if(x1 == x2 && y1 == y2 && r1 == r2) {
        return -1
    }
    // case 2-1: 두 원의 반지름 합보다 중점간 거리가 더 길 때
    // 두 원이 서로 떨어져 있어 접점이 없으므로 0을 리턴한다.
    else if (distance > pow(sum, 2)) {
        return 0
    }
    // case 2-2: 원 안에 원이 있으나 내접하지 않을 때
    // 큰 원 안에 작은 원이 떨어져 있는 형태로 겹쳐있는 형태이므로 접점이 없어 0을 리턴한다.
    else if (distance < pow(minus, 2)) {
        return 0
    }
    // case 3-1: 내접할 때
    // 큰 원 안에 작은 원이 있지만 한 점이 붙어 있으므로 1을 리턴한다.
    else if (distance == pow(minus, 2)) {
        return 1
    }
    // case 3-2: 외접할 때
    // 바깥에서 원 끼리 한 점이 붙어있는 형태이므로 1을 리턴한다.
    else if (distance == pow(sum, 2)) {
        return 1
    }
    // 나머지 케이스는 모두 점 2개가 겹치는 형태이므로 2를 리턴한다.
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
