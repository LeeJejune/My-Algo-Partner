//
//  불!.swift
//  Minjae
//  https://www.acmicpc.net/problem/5427
//  Created by 김민재 on 2023/03/22.
//

import Foundation

let fire = "*"
let wall = "#"
let space = "."
let visited = "+"


var tc = Int(readLine()!)! // 테스트 케이스 입력받기

while tc != 0 {

    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let w = input[0] // Width
    let h = input[1] // Height

    var map: [[String]] = []

    var queue: [(Int, Int)] = [] // 상근 큐
    var fireQueue: [(Int, Int)] = [] // 불 큐

    for _ in 0..<h {
        map.append(readLine()!.map({ String($0) }))
    } // 맵에 입력받기

    for i in 0..<h {
        for j in 0..<w {
            if map[i][j] == "@" {
                queue.append((i, j)) // 상근 위치 (y, x) 큐에 넣기
                map[i][j] = visited
            } else if map[i][j] == "*" {
                fireQueue.append((i, j)) // 불 위치 (y, x) 큐에 넣기, 불은 여러개일 수 있다
            }
        }
    }

    // 4방향
    let dy = [-1, 1, 0, 0]
    let dx = [0, 0, 1, -1]

    var qIndex = 0 // 상근 큐 iterator
    var fireIndex = 0 // 불 큐 iterator

    var time = 0 // 시간
    var isSuccess = false // 성공여부 flag

    // 상근 큐를 다 돌 때까지, 더이상 상근이 움직일 수 없을 때까지 while
outer: while queue.count > qIndex {

        let fireQueueCount = fireQueue.count // 진입시 fireQueue에 담겨있는 큐의 개수를 가지고
        while fireIndex < fireQueueCount { // 진입시의 큐 개수만큼 while문으로 돌면서 인근의 위치 큐에 넣기
            let (y, x) = fireQueue[fireIndex] // dequeue하고
            fireIndex += 1 // index 1증가시켜서 다음값 가리키게 하기

            for i in 0..<4 { // 4방향 탐색
                let ny = y + dy[i] // 다음 위치 y 좌표
                let nx = x + dx[i] // 다음 위치 x 좌표

                // 불은 맵 범위 안이여야하기 때문에 맵 안의 범위이고, 빈공간이거나 상근이가 지난 위치라면 불이 갈 수 있다
                if 0..<h ~= ny && 0..<w ~= nx && (map[ny][nx] == space || map[ny][nx] == visited) {
                    fireQueue.append((ny, nx)) // 갈수 있다면 불 큐에 다음 위치 튜플 enqueue
                    map[ny][nx] = fire // 불 전파시키기
                }
            }
        }

        let qCount = queue.count // 위와 동일하게 진입시 상근 큐에 있는 값 저장
        while qIndex < qCount { // 해당 값 만큼 돌면서 bfs
            let (y, x) = queue[qIndex] // dequeue하는 과정: 빼고
            qIndex += 1 // index + 1 로 다음 값 가르키게 하기

            for i in 0..<4 { // 4방향 탐색
                let ny = y + dy[i]
                let nx = x + dx[i]

                if ny >= h || nx >= w || ny < 0 || nx < 0 { // 맵 밖으로 나갔다면?
                    print(time + 1) // 맵 밖으로 나가는 것은 1초 걸리기 때문에 +1 시키고 종료
                    isSuccess = true // flag값 성공으로 바꾸기
                    break outer // 정답을 구했으니 완전히 탐색 종료
                }

                // 여기로 내려왔다는 것은 맵 안의 범위라는 뜻
                if map[ny][nx] == space { // 다음 위치가 빈공간일 때만 이동 가능 (뱍, 불, 이미 갔던 곳 제외)
                    queue.append((ny, nx)) // 큐에 다음 위치 좌표 enqueue
                    map[ny][nx] = visited // 다음 위치 방문 표시하기
                }
            }
        }
        time += 1 // 상근이가 이동한 후에 time 증가시키기
    }

    if !isSuccess { // outer while문을 다 돌았는데도 여전히 isSucess가 false라면 탈출불가능.
        print("IMPOSSIBLE") //
    }

    tc -= 1
}
