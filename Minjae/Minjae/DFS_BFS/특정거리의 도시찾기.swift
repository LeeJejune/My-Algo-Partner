//
//  특정 거리의 도시 찾기.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/25.
//

import Foundation

// Queue 구현
struct Queue<T> {
    var array: [T?] = []
    var head = 0
    
    var count: Int {
        return array.count - head
    }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard head < array.count,
              let element = array[head] else {
            return nil
        }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head) / Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    var front: T? {
        if isEmpty {
            return nil
        }
        return array[head]
    }
}

let input = readLine()!.split(separator: " ").map { Int($0)! } // 입력값 받기
let n = input[0] // 도시의 개수
let m = input[1] // 도로의 개수
let k = input[2] // 거리 정보 K
let x = input[3] // 출발 도시 번호 X

var graph = [[Int]](repeating: [], count: n + 1) // 그래프를 연결리스트로 표현하기 위해 초기화
var distance = [Int](repeating: -1, count: n + 1) // 출발 도시-도시 거리를 나타낼 거리 배열 초기화 (-1로 초기화)
distance[x] = 0 // 출발 도시는 거리 0으로 초기화

for _ in 0..<m {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let a = input[0] // source 도시
    let b = input[1] // destination 도시
    graph[a].append(b) // 단방향이기 때문에 a -> b로만 추가
}

// BFS 구현
func bfs(start: Int) {
    // start: 시작 도시의 번호
    var q = Queue<Int>() // Queue
    q.enqueue(start) // Queue 시작 시 start 가지고 시작
    
    while !q.isEmpty { // 큐에 아이템이 있으면 계속 반복
        guard let v = q.dequeue() else { return } // 앞에서 dequeue로 도시를 가져와서
        
        for i in graph[v] { // 인접한 도시들 중
            
            if distance[i] == -1 { // 아직 방문하지 않은(-1) 도시라면??
                distance[i] = distance[v] + 1 // 해당 도시거리를 앞의 도시+1 로 변경
                q.enqueue(i) // 큐에 다음 인접한 도시들 삽입
            }
        }
    }
}

bfs(start: x) // 시작도시로 BFS 탐색 시작

var answer: [Int] = [] // k만큼 거리가 떨어져있는 도시들을 담기 위한 정답 배열 초기화
for i in 0..<distance.count {
    if distance[i] == k { // 해당 거리가 k라면?
        answer.append(i) // answer 배열에 인덱스, 즉 도시번호 넣기
    }
}

if answer.isEmpty { // answer배열이 비었다면 최단 거리 K인 도시가 존재하지 않기 때문에 -1 출력
    print(-1)
} else { // answer배열이 비어있지 않다면
    for i in answer {
        print(i) // 순서대로 출력
    }
}
