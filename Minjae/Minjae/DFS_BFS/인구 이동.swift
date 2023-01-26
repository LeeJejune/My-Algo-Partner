//
//  인구 이동.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/26.
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

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0] // N * N
let L = input[1] // L 이상
let R = input[2] // R 이하 차이 나는 나라들만 국경 오픈가능

var board: [[Int]] = [] // 나라 보드 입력받기
for _ in 0..<N {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    board.append(input)
}

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

func bfs(start: (Int, Int), union: inout [[Int]], index: Int) {
    
    var united: [(Int, Int)] = [] // 연합 국가들의 위치를 담을 배열
    united.append((start.0, start.1)) // 시작 국가도 연합에 당연히 포함돼야함
    
    var q = Queue<(Int, Int)>() // for BFS
    q.enqueue(start)
    union[start.0][start.1] = index // 시작지점에게 연합 번호 부여
    
    var total = board[start.0][start.1] // 연합 인구수 총합
    var count = 1 // 연합 나라 수, 시작나라 포함해야하기 때문에 1부터
    
    while !q.isEmpty {
        if let v = q.dequeue() {
            let y = v.0
            let x = v.1
            
            for i in 0..<4 { // 상, 하, 좌, 우 탐색
                let ny = y + dy[i]
                let nx = x + dx[i]
                if ny >= 0 && ny < N && nx >= 0 && nx < N && union[ny][nx] == -1 { // 범위 안이면서, 아직 미처리된 나라이면?
                    let diff = abs(board[ny][nx] - board[y][x])
                    if diff >= L && diff <= R { // 게다가 인구수 차이가 L~R라면?
                        // 연합 맺기
                        q.enqueue((ny, nx))
                        
                        total += board[ny][nx] // 인구수 통합
                        union[ny][nx] = index // 같은 연합 번호 부여하기
                        united.append((ny, nx)) // 후에 인구를 나누기 위한 연합나라 배열에 담기
                        count += 1 // 연합 나라수 1증가
                    }
                }
            }
        }
    }
    
    let updated = total / count // 분배되어야할 인구수
    
    for unit in united { // 연합나라들 인구 수 업데이트
        board[unit.0][unit.1] = updated
    }
}

var answer = 0 // 정답값, 몇일?
while true {
    // 연합을 해체하고 국경선을 닫는다
    var union = [[Int]](repeating: [Int](repeating: -1, count: N), count: N)
    
    var index = 0 // 연합 번호
    
    for i in 0..<N {
        for j in 0..<N {
            if union[i][j] == -1 { // 아직 해당 나라가 처리되지 않았다면??
                bfs(start: (i, j), union: &union, index: index) // bfs로 조건에 맞는 나라 연합 맺기
                index += 1 // 연합을 다 맺었다면 다음 연합 번호로
            }
        }
    }
    
    if index == N * N {
        // 연합 번호가 N*N가 됐다는 것은 모든 칸을 탐색했다는 것인데,
        // 모든 칸을 탐색했다는 것은 조건에 맞게 연합을 맺은 나라가 하나도 없다는 것이므로
        // 더이상 인구이동이 없다는 것을 뜻하므로 break
        break
    }
    answer += 1 // 위에서 break되지 않았다면, 아직 인구이동할 여지가 남았다는 뜻이므로 하루를 올리고 while문 반복
}

print(answer) // 정답값 출력



