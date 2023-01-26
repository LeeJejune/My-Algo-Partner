//
//  경쟁적 전염.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/25.
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


var input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0] // N x N
let K = input[1] // 1번~K번 종류의 바이러스

var board: [[Int]] = [] // 시험관 보드 초기화하기
for _ in 0..<N {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    board.append(input) // 시험관 보드 입력받기
}

input = readLine()!.split(separator: " ").map({ Int($0)! })
let S = input[0] // S초 지난 후의
let X = input[1] // 보드의 X행
let Y = input[2] // Y열에 있는 바이러스 종류 출력하라.

// 상, 하, 좌, 우
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

/*
 Queue<(Int, Int, Int, Int)>
 (Int, Int, Int, Int): (행, 열, 바이러스종류, 시간)
 마지막에 바이러스 종류를 추가해서 바이러스 종류를 기준으로 오름차순으로 정렬해서
 바이러스 번호가 낮은 것부터 퍼질 수 있게끔 하였다.
 --------------
 이전 내 풀이보다 개선점
 큐에 시간을 함께 넣음으로써 보다 더 직관적으로 시간 조건을 확인할 수 있었다.
 */

var q = Queue<(Int, Int, Int, Int)>()
for i in 0..<N { // 모든 시험관 탐색하면서
    for j in 0..<N {
        if board[i][j] != 0 { // 바이러스이다?
            q.enqueue((i, j, board[i][j], 0)) // 그렇다면 Queue에 삽입
        }
    }
}

q.array.sort { a, b in
    // Queue의 array를 바이러스 종류(tuple.2)를 기준으로 오름차순 정렬
    return a?.2 ?? 0 < b?.2 ?? 0
}


while !q.isEmpty {
    
    if let v = q.dequeue() {
           
        let y = v.0 // 바이러스의 행
        let x = v.1 // 바이러스의 열
        let virusType = board[y][x] // 바이러스 종류
        let time = v.3
        
        if time == S {
            break
        }
        
        for i in 0..<4 {
            let ny = y + dy[i] // 다음 바이러스가 퍼지게 될 위치의 행
            let nx = x + dx[i] // 다음 바이러스가 퍼지게 될 위치의 열
            
            if ny >= 0 && ny < N && nx >= 0 && nx < N { // 다음 위치가 범위 안에 있다면?
                if board[ny][nx] == 0 { // 다음 위치가 빈칸이라면
                    board[ny][nx] = virusType // 바이러스를 전파시키고
                    q.enqueue((ny, nx, virusType, time + 1)) // 큐에 다음 (다음 위치, 바이러스 종류) 삽입
                }
            }
        }
    }
}

print(board[X-1][Y-1]) // S초동안의 전파가 모두 끝난 후 X-1, Y-1 위치의 바이러스를 출력한다

