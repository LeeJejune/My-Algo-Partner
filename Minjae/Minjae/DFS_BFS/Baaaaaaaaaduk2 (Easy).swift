//
//  Baaaaaaaaaduk2 (Easy).swift
//  Minjae
//  https://www.acmicpc.net/problem/16988
//  Created by 김민재 on 2023/03/27.
//

import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0] // 행
let m = input[1] // 열

var board: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)

for i in 0..<n {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    for j in 0..<m {
        board[i][j] = input[j]
    }
}

let dy = [1, -1, 0, 0]
let dx = [0, 0, 1, -1]

// 그냥 돌을 둘 수 있는 모든 빈칸에 내 돌들을 2개씩 놔본다
// 그 때마다 내가 지울 수 있는 상대방 돌의 개수를 max로 갱신시킨다.
// 모든 경우의 수를 다 돌았으면 갱신시키던 정답 출력하기


func bfs() -> Int { // 상대돌 기준으로 지금 자기 주변에 내(1)껄로 깔렸는지 확인하는 BFS
    var count = 0
    var visited: [[Bool]] = [[Bool]](
        repeating: [Bool](repeating: false, count: m),
        count: n
    ) // 현 상태의 보드에 대해서 검사를 해야한다. 처음에 방문처리를 큐랑 같이 안에 넣어버렸더니 엉뚱한 값이 나온다. 당연하지 임마
    // 보드의 방문처리 관련 상태값

    for i in 0..<n {
        for j in 0..<m {
            if board[i][j] == 2 && !visited[i][j] { // 상대돌 && 방문X
                var queue: [(Int, Int)] = [] // 상대 돌 좌표 넣기 (y, x)
                var qIndex = 0
                queue.append((i, j)) //
                visited[i][j] = true // 방문처리
                var isSuccess = true // 성공여부 flag
                while qIndex < queue.count { //
                    let (y, x) = queue[qIndex] //
                    qIndex += 1 // dequeue

                    for i in 0..<4 {
                        let ny = y + dy[i]
                        let nx = x + dx[i]

                        // 범위 안이고 아직 안간곳이면?
                        if 0..<n ~= ny && 0..<m ~= nx && !visited[ny][nx] {
                            if board[ny][nx] == 0 { // 0이면 망한거니까 false
                                isSuccess = false // 망했으니까 false로
                            } else if board[ny][nx] == 2 { // 상대돌(2)이면 일단 더 나아간다
                                visited[ny][nx] = true // 방문처리해주고
                                queue.append((ny, nx)) // 큐에 삽입
                            }
                        }
                    }
                }
                if isSuccess { // 만약 한번이라도 0이 있었으면 의미 없다. 0이 하나도 없었다면?
                    count += qIndex // 탐색한 상대돌 개수 만큼 더해준다
                }
            }
        }
    }

    return count
}

var emptySpaces: [(Int, Int)] = [] // 빈공간들
for i in 0..<n {
    for j in 0..<m {
        if board[i][j] == 0 {
            emptySpaces.append((i, j)) // 빈공간 보이면 다 넣어
        }
    }
}

var answer = 0

for i in 0..<emptySpaces.count { // 빈공간이 2개여야하니까 2중 for문
    for j in i+1..<emptySpaces.count {

        let one = emptySpaces[i] // 빈공간 2개 고르기
        let two = emptySpaces[j] //

        board[one.0][one.1] = 1 // 빈공간 2개 내가 두었다치고
        board[two.0][two.1] = 1

        let count = bfs() // 그 때 없어지는 상대돌의 개수, 불가능하면 0
        answer = max(answer, count) // 정답 갱신

        board[one.0][one.1] = 0 // 원상 복귀
        board[two.0][two.1] = 0 // 원상 복귀해야 다시 다른 곳에 2개를 두니까
    }
}

print(answer) // 그렇게 모든 경우의 수를 돌고 정답 출력하기
