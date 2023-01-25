//
//  연구소.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/25.
//

import Foundation

// 완전탐색으로 벽을 빈칸에 다 3개씩 세워보면서(조합)
// 바이러스를 쭉 퍼뜨려보기
// 그러고 0 빈칸세어서 안전영역 크기 최대값을 업데이트해가면서
// 최댓값 출력하기

// Queue
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


let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0] // 가로
let M = input[1] // 세로

var board: [[Int]] = [] // 연구소 보드 초기화

for _ in 0..<N {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    board.append(input) // 연구소 보드 입력받기
}

var spaces: [(Int, Int)] = [] // 0(빈칸)들의 위치만 모아놓을 배열
for i in 0..<N {
    for j in 0..<M {
        if board[i][j] == 0 { // 빈칸일 경우
            spaces.append((i, j)) // 빈칸 위치 넣기
        }
    }
}

// 벽 3개를 세우는 조합
var zeroCombi: [[(Int, Int)]] = [] // 0의 위치들을 이용해서 조합 n C 3의 결과들을 담을 배열
func combi(start: Int, b: [Int]) {
    var b = b
    if b.count == 3 {
        var tmp: [(Int, Int)] = []
        for i in b {
            tmp.append(spaces[i])
        }
        zeroCombi.append(tmp)
        return
    }
    
    for i in start+1..<spaces.count {
        b.append(i)
        combi(start: i, b: b)
        b.popLast()
    }
    return
}
combi(start: -1, b: [])


let dy = [-1, 1, 0, 0]
let dx = [0, 0, 1, -1]
func bfs(_ start: (Int, Int)) { // 바이러스 퍼뜨리기
    var q = Queue<(Int, Int)>()
    q.enqueue(start)
    
    while !q.isEmpty {
        guard let v = q.dequeue() else { return }
        
        let y = v.0
        let x = v.1
        
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            if ny >= 0 && ny < N && nx >= 0 && nx < M { // 다음 위치가 범위 안일 경우
                if board[ny][nx] == 0 { // 다음 위치가 0, 즉 빈칸일 경우
                    board[ny][nx] = 2 // 바이러스로 업데이트
                    q.enqueue((ny, nx))
                }
            }
        }
    }
}


var answer = 0
for combi in zeroCombi {
    let tmp = board // 상태 복원 위해 초기 보드 tmp에 저장해놓기
    
    // 벽 3개 세우기
    for comb in combi {
        board[comb.0][comb.1] = 1
    }
    
    // 바이러스 퍼뜨리기
    for i in 0..<N {
        for j in 0..<M {
            if board[i][j] == 2 { // 2, 바이러스 발견하면
                bfs((i, j)) // 퍼뜨리기 시작
            }
        }
    }
    
    // 안전 영역 크기(빈칸 개수) 세고 answer값 max값으로 최신화
    var spaceCnt = 0
    for i in 0..<N {
        for j in 0..<M {
            if board[i][j] == 0 {
                spaceCnt += 1
            }
        }
    }
    answer = max(answer, spaceCnt)
    
    // 벽3개 설치, 바이러스 퍼뜨리기 이전 상태 복원
    board = tmp
}

print(answer) // 정답 출력


