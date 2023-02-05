//
//  main.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/25.
//

import Foundation

// BFS
// Breadth first Search
var graph = [
    [],
    [2, 3, 8],
    [1, 7],
    [1, 4, 5],
    [3, 5],
    [3, 4],
    [7],
    [2, 6, 8],
    [1, 7]
]

var visited = [Bool](repeating: false, count: 9)

func bfs(_ start: Int) {
    var q = Queue<Int>()
    q.enqueue(start)
    
    // 현재 노드 방문처리
    visited[start] = true
    
    while !q.isEmpty {
        guard let v = q.dequeue() else { return }
        print(v, terminator: " ")
        for i in graph[v] {
            if !visited[i] {
                q.enqueue(i)
                visited[i] = true
            }
        }
    }
}


bfs(1)
print()
