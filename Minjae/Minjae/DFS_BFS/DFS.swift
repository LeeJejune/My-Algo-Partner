//
//  main.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/21.
//

import Foundation
/*
인접 리스트 (연결 리스트)
메모리를 효율적으로 사용할 수 있지만, 어떤 노드와 어떤 노드의 연결여부를 확인할 때 모두 순회해서 확인해야한다는 단점이 존재
반면에 인접 행렬 같은 경우에는 모든 경우에 대해 배열을 만들어야하기 때문에 메모리면에서는 비효율적이지만
연결여부를 확인하고자 할 때는 [2][1] 이런식으로 바로 접근해서 확인할 수 있기때문에 속도면에서 이득을 가질 수 있다

 아래는 연결 리스트-DFS 예시
 */

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

func dfs(v: Int) {
    // 현재 노드를 방문처리
    visited[v] = true
    print(v, terminator: " ")
    // 인접한 노드들 탐색하면서
    for i in graph[v] {
        // 아직 방문하지 않았으면?
        if !visited[i] {
            dfs(v: i) // dfs
        }
    }
}

dfs(v: 1)
print()
