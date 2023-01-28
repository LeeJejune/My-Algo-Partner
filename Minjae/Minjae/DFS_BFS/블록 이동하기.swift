//
//  블록 이동하기.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/27.
//

import Foundation

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

struct Pos: Hashable {
    // Set에서 tuple 형식으로 넣기 위해서는 struct형식에 Hashable을 채택해야함
    let y: Int
    let x: Int
}


func solution(_ board:[[Int]]) -> Int {
    
    let N = board.count // N x N
    
    // 맵에서 벽 한 줄 테두리 두르기 (맵 확장)
    // 범위 계산 더 편하게하기 위해서 (로봇이 2칸짜리)
    var newBoard = [[Int]](repeating: [Int](repeating: 1, count: N + 2), count: N + 2)
    
    for i in 0..<N {
        for j in 0..<N {
            newBoard[i + 1][j + 1] = board[i][j]
        }
    }
    
    let dy = [-1, 1, 0, 0]
    let dx = [0, 0, -1, 1]
    
    
    // 현재 위치에서 갈 수 있는 모든 위치 후보군 뽑기
    func getNextPos(v: [Pos], board: [[Int]]) -> [[Pos]] {
        
        var candidate: [[Pos]] = [] // 위치 후보군을 담을 배열
        
        let y1 = v[0].y // 현재 위치 첫번째칸 y
        let x1 = v[0].x // 첫번째칸 x
        
        let y2 = v[1].y // 두번째칸 y
        let x2 = v[1].x // 두번째칸 x
        
        
        for i in 0..<4 { // 상 하 좌 우 시에
            let ny1 = y1 + dy[i] // 다음 첫번째칸 y
            let nx1 = x1 + dx[i] // x
            
            let ny2 = y2 + dy[i] // 다음 두번째칸 y
            let nx2 = x2 + dx[i] // x
            
            // 빈공간이라면?
            if board[ny1][nx1] == 0 && board[ny2][nx2] == 0 {
                candidate.append([Pos(y: ny1, x: nx1), Pos(y: ny2, x: nx2)])
            }
        }
        
        // 회전 위치 확인
        if y1 == y2 { // 로봇 두칸이 같은 행, 즉 가로로 돼있다면?
            for i in [-1, 1] {
                // 위 아래 0 이라면?
                if board[y1 + i][x1] == 0 && board[y2 + i][x2] == 0 {
                    candidate.append([Pos(y: y1, x: x1), Pos(y: y1 + i, x: x1)])
                    candidate.append([Pos(y: y2, x: x2), Pos(y: y2 + i, x: x2)])
                }
            }
        } else if x1 == x2 { // 같은 열, 즉 세로로 돼있다면?
            for i in [-1, 1] { // 왼쪽, 오른쪽 0 이라면?
                if board[y1][x1 + i] == 0 && board[y2][x2 + i] == 0 {
                    candidate.append([Pos(y: y1, x: x1), Pos(y: y1, x: x1 + i)])
                    candidate.append([Pos(y: y2, x: x2), Pos(y: y2, x: x2 + i)])
                }
            }
        }
        
        return candidate
    }
    
    // BFS 실행하기
    func bfs(start: [(Int, Int, Int)]) -> Int {
        var q = Queue<[(Int, Int, Int)]>()
        q.enqueue(start)
        
        let firstY = start[0].0
        let firstX = start[0].1
        
        
        let secondY = start[1].0
        let secondX = start[1].1
        
        var visited = Set<[Pos]>() // 방문여부 확인하기 위한 배열
        visited.insert(
            [Pos(y: firstY, x: firstX), Pos(y: secondY, x: secondX)]
        )
        
        // visited에 있으면 방문한것임
        
        
        while !q.isEmpty {
            if let v = q.dequeue() {
                
                let nowY1 = v[0].0
                let nowX1 = v[0].1
                
                let nowY2 = v[1].0
                let nowX2 = v[1].1
                
                let time = v[0].2
                
                if (nowY1 == N && nowX1 == N) || (nowY2 == N && nowX2 == N) { // 로봇 두칸 중에 한칸이라도 N x N 마지막에 도달했다면??
                    return time // 당시 시간 return
                }
                
                var s = Set<[Pos]>() // 후보군 뽑아서 Set으로 중복제거
                // [(1,1), (2,1)] == [(2,1), (1,1)] 이런 경우는 같은 위치에 있는 것임
                
                for i in getNextPos(v: [Pos(y: nowY1, x: nowX1), Pos(y: nowY2, x: nowX2)], board: newBoard) {
                    s.insert([Pos(y: i[0].y, x: i[0].x), Pos(y: i[1].y, x: i[1].x)])
                }
                
                for nextPos in s { // 후보군을 모두 탐색하면서
                    
                    let ny1 = nextPos[0].y
                    let nx1 = nextPos[0].x
                    let pos1 = Pos(y: ny1, x: nx1)
                    
                    let ny2 = nextPos[1].y
                    let nx2 = nextPos[1].x
                    let pos2 = Pos(y: ny2, x: nx2)
                    
                    let tmp = [pos1, pos2]
                    
                    if !visited.contains(tmp) { // 방문하지 않았다면??
                        
                        q.enqueue([(ny1, nx1, time + 1), (ny2, nx2, time + 1)]) // time 증가한 채로 큐에 삽입
                        visited.insert(tmp) // 방문처리
                    }
                }
            }
        }
        
        return 0
    }
    
    
    let positions = [(1, 1, 0), (1, 2, 0)]
    
    return bfs(start: positions)
}




_ = solution(
    [
        [0, 0, 0, 1, 1],
        [0, 0, 0, 1, 0],
        [0, 1, 0, 1, 1],
        [1, 1, 0, 0, 1],
        [0, 0, 0, 0, 0]
    ]
)
