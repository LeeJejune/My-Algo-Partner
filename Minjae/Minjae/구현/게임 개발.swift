//
//  게임 개발.swift
//  algo
//
//  Created by 김민재 on 2022/12/21.
//

import Foundation

var input = readLine()!.split(separator: " ").map {Int($0)!} // 보드는 N x M 정사각형이고, 그에 대한 입력을 받는 것이다.
let N = input[0] // N
let M = input[1] // M
input = readLine()!.split(separator: " ").map { Int($0)! } // 캐릭터가 서있는 위치(y, x)와 방향을 입력받는 것이다.
var y = input[0] // y
var x = input[1] // x
var d = input[2] // direction, 캐릭터가 보고 있는 방향을 뜻한다.

var visited: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
// 캐릭터가 방문했는지 안했는지를 확인하기 위한 방문 여부(1 or 0)을 담고 있는 배열이다.
visited[y][x] = 1
// 처음 시작하는 곳은 방문한 곳으로 치기 때문에 1로 만들고 시작한다.

var map: [[Int]] = [] // map은 바다와 육지로 구성된 맵을 만들기 위한 배열이다.
for _ in 0..<N {
    map.append(readLine()!.split(separator: " ").map { Int($0)! })
    // 입력받는 값(1: 바다, 0: 육지)을 리스트로 만들어 map에 넣어 map을 완성한다.
}

func changeDirection(direction: Int) -> Int {
    // 입력받은 direction 방향을 반시계 방향으로 90도 돌려서 해당 방향을 int로 돌려주는 함수이다.
    switch direction {
    case 0: // 북 -> 서
        return 3
    case 1: // 동 -> 북
        return 0
    case 2: // 남 -> 동
        return 1
    case 3: // 서 -> 남
        return 2
    default:
        return -1
    }
}

// 북,동,남,서 의 순서로 이동하는 방향에 대한 정의를 담은 배열이다.
// 북, 동, 남, 서
let moves = [(-1, 0), (0, 1), (1, 0), (0, -1)]


var changeCount = 0 // 캐릭터가 네방향을 모두 검사하고, 갈 곳이 없다고 판단된다면 뒤로 가야하기 때문에, 네방향을 모두 돌았을 때를 판단하기 위한 방향changeCount 변수이다.


var answer = 1 // 정답을 출력할 변수이다. 맨처음 캐릭터가 시작하는 위치를 포함해야하기 때문에 1부터 시작한다.
while true { // 뒤로 갔을 시에 바다일 경우에 break되기 때문에 while문을 이용했다.
    d = changeDirection(direction: d) // 시작시 왼쪽 방향부터 검사하기 때문에 기존의 방향을 전환시키고 시작한다.

    var move = moves[d] // 방향 전환한 이후 해당 방향으로 가는 이동 방법을 가져온다.
    var ny = move.0 // 가져온 이동 경로의 y 값
    var nx = move.1 // 가져온 이동 경로의 x 값
    if visited[y + ny][x + nx] == 1 || map[y + ny][x + nx] == 1 {
        // y(현재 y좌표) + ny (다음 이동경로 y값), x(현재 x좌표) + nx(다음 이동경로 x값)
        // 위의 좌표를 기준으로 visited 방문여부 배열에서 캐릭터가 해당 곳을 방문했거나,
        // map에서 해당 좌표의 위치한 곳이 1, 즉 바다라면 아래 해당 if문으로 들어오게 된다.
        
        changeCount += 1 // while문 시작시에 방향을 전환해주기 때문에 이곳에서는 간단히 방향전환count를 1 늘려준다.
        if changeCount == 4 { // changeCount가 4라면 모든 방향을 검사했음에도 갈 곳이 없다는 것이기 때문에 뒤로 가야한다.
            move = moves[d] // 해당 방향을 유지한채 뒤로 가야한다.
            ny = -move.0 // - 를 붙여 반대 방향을 가도록 한다.
            nx = -move.1 // 위와 동일한 기능을 한다.
            y = y + ny // 반대 방향으로 y, x 값을 이동시킨다.
            x = x + ny //
            visited[y][x] = 1 // 반대 방향으로 이동시킨 곳도 방문처리를 해두었다. 없어도 될 것 같은 느낌
            changeCount = 0 // 네방향 검사를 위한 changeCount를 0으로 초기화해준다.
            
            if map[y][x] == 1 { // 이동한 곳이 map에서 1, 즉 바다라면 while문을 종료한다.
                break
            }
        }
    } else if visited[y + ny][x + nx] == 0 && map[y + ny][x + nx] == 0 {
        // 방향 전환한 이후의 좌표값을 기준으로 visited가 0, 즉 방문하지 않았고,
        // map도 해당 위치가 0, 즉 육지 이동할 수 있는 곳이라면 캐릭터를 이동시킨다.
        y = y + ny // 캐릭터의 y좌표값을 update시킨다.
        x = x + nx // 캐릭터의 x좌표값을 update시킨다.
        visited[y][x] = 1 // 캐릭터가 이동한 곳을 방문처리해준다.
        answer += 1 // 정상적으로 이동한 경우이기 때문에 answer를 1 늘려준다.
        changeCount = 0 // 이동을 마쳤으므로 네방향 검사를 위한 changeCount는 0으로 초기화시켜준다.
    }
}

print(answer) // while문이 종료되면 정답을 출력한다.



/*
 처음 실패했던 이유
 1. changeDirection을 시작시에 한번 해주는데, 갈 곳이 없을 경우에 changeDirection을 한번 더 해주고 있어서
 방향 전환이 두번씩 됐었다.
 2. changeCount를 이동했을 시와 뒤로 갔을 때 모두 초기화 해주어야했는데 그 부분을 깜빡함
 */

