//
//  Fibonacci.swift
//  baekjoon-algorithm
//
//  Created by 민경준 on 2/26/25.
//
// https://hongjw1938.tistory.com/47 Dynamic Programming(동적 계획법)

import Foundation

let count: Int = Int(readLine()!)!
var storage: [Int: [Int]] = [:]

func fibonacci(_ n: Int) -> [Int] {
    // 한 번 구했던 값이 있으면 바로 리턴.
    if let value = storage[n] {
        return value
    } else
    if (n == 0) {
        return [1, 0]
    } else
    if (n == 1) {
        return [0, 1]
    } else {
        let first = fibonacci(n-1)
        let second = fibonacci(n-2)
        // 새로 구한 값을 저장한다.
        // [0] = 0의 갯수
        // [1] = 1의 갯수
        storage[n] = [first[0] + second[0], first[1] + second[1]]
        return [first[0] + second[0], first[1] + second[1]]
    }
}

for _ in 0 ..< count {
    let value = Int(readLine()!)!
    
    let result = fibonacci(value)
    let zero = result[0]
    let one = result[1]
    print("\(zero) \(one)")
}
