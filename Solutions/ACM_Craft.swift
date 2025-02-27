//
//  ACM_Craft.swift
//  baekjoon-algorithm
//
//  Created by 민경준 on 2/27/25.
//

import Foundation

// https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88
// 시간초과를 방지 하기 위해 입출력의 시간을 줄이는 라이브러리입니다.
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        index = 0
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        
        return buffer.withUnsafeBufferPointer { $0[index] }
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45{ isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
    
    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

let file: FileIO = .init()
let count: Int = file.readInt()

struct Edge {
    let source: Int
    let destination: Int
}

for _ in 0..<count {
    // 건물의 개수: N
    // 건설순서 규칙의 개수: K
    let N = file.readInt()
    let K = file.readInt()
    
    // 건물당 건설에 걸리는 시간 D1, D2, ..., DN
    var D: [Int] = []
    for _ in 0 ..< N {
        let intValue = file.readInt()
        D.append(intValue)
    }
    
    // 위상 정렬을 활용 하기 위한 변수들.
    // edges: 노드들의 연결 리스트.
    // indegree: 해당 노드(Key)의 진입 차수(Value)에 대한 딕셔너리.
    var edges: [Edge] = []
    var indegree: [Int: Int] = [:]
    for _ in 0 ..< K {
        // 출발 노드: s
        // 도착 노드: d
        let s = file.readInt()
        let d = file.readInt()
        
        let edge: Edge = .init(source: s, destination: d)
        edges.append(edge)
        
        // 도착 노드에 대한 진입 차수를 한 개 증가시킨다.
        indegree[d, default: 0] += 1
    }
    
    let arrive = file.readInt()
    var queue: [Int] = []
    
    /**
     각 건물까지 건설 하는데 걸리는 시간을 최대 값으로 업데이트하여 저장하는 공간.
     ex) P2 = max(P2, P1 + T2)
     
     건물 자체 건설 시간이 1 -> 10, 2 -> 5 일때
     2를 건설 하는데 걸리는 시간은 15이다.
     
     P2는 기존에 0 이였고, 10 + 5 가 더 큰 값이기 때문에
     P2는 15로 업데이트 되게 된다.
     
     만약 이후에 2번 노드에 대해서 다른 출발 노드가 존재 하면
     해당 노드에 대해서도 똑같은 계산식을 이용 하여 최대 값으로 업데이트 하면 된다.
     P2 = max(P2, P3 + T2)
     
     최대값으로 업데이트 하는 이유는, 해당 건물을 건설하기 위해 이전 건물을 모두 지어야 하는데
     그렇게 되면 최소 건설 시간이 아이러니 하게도 건설 하는데 가장 오래 걸리는 건물의 시간을 더해야 나오게 된다.
     */
    var dp: [Int: Int] = [:]
    
    for i in 1 ... N {
        // 진입 차수가 없는 노드부터 큐에 넣는다.
        if indegree[i] == nil {
            queue.append(i)
            dp[i] = D[i - 1]
        }
    }
    
    while !queue.isEmpty {
        // 큐의 가장 앞에 있는 노드를 가져오고 배열에서 제거 한다.
        let current = queue.removeFirst()
        
        for edge in edges where edge.source == current {
            // 진입 차수가 존재하고 0 이상인 경우에만 계산을 한다.
            guard let value = indegree[edge.destination], value > 0 else { continue }
            indegree[edge.destination] = value - 1
            
            // 도착 노드에 대한 건설 시간을 업데이트 한다.
            let a = dp[edge.destination, default: 0]
            let b = dp[current, default: 0]
            let time = D[edge.destination - 1]
            
            dp[edge.destination] = max(a, b + time)
            
            // 만약 도착 노드의 진입 차수가 0이 되었다면 큐에 담아준다.
            guard (value - 1) == 0 else { continue }
            queue.append(edge.destination)
        }
    }
    
    let result = dp[arrive, default: 0]
    print(result)
}
