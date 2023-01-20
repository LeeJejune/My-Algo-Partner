//
//  뱀.swift
//  algo
//
//  Created by 김민재 on 2022/12/24.
//

import Foundation

let N = Int(readLine()!)! // 보드의 크기
var board = [[Int]](repeating: [Int](repeating: 0, count: N+1), count: N+1) // 0으로 초기화된 보드를 만들어준다. 이때 크기는 편하게 1,1부터 하기 위해서 N+1로 크기를 잡는다.

let apple = 1 // 사과는 보드에 1로 표시할 예정이다.
let snake = 2 // 뱀은 보드에 2로 표시할 예정이다.


let K = Int(readLine()!)! // 사과의 개수
for _ in 0..<K {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let y = input[0] // 입력받는 사과의 y좌표
    let x = input[1] // 입력받는 사과의 x좌표
    board[y][x] = apple // 보드의 입력받은 좌표에 사과를 저장한다.
}

struct Turn { // 방향 회전 명령을 담을 struct 구조체이다.
    let time: Int // 회전을 할 시간
    let direction: String // 회전을 하는 방향
}

let L = Int(readLine()!)! // 방향 변환 횟수 L
var turns: [Turn] = [] // 방향 변환 횟수를 담는 베열
for _ in 0..<L {
    let input = readLine()!.split(separator: " ")
    let time = Int(input[0])! // 입력받는 방향 변환 시간
    let dir = String(input[1]) // 입력받는 방향 변환 방향
    
    let turn = Turn(time: time, direction: dir) // 입력받는 값들로 Turn구조체를 만들어서
    turns.append(turn) // 배열에 넣어준다.
}

// 동, 남, 서, 북
// 0   1  2   3
// default 방향이 동쪽으로 시작하기 때문에 동쪽부터 배치해주었다.
let moves = [(0, 1), (1, 0), (0, -1), (-1, 0)]

func turn(currDirection: Int, direction: String) -> Int {
    /*
     currDirection : 현재 방향
     direction : 입력받는 회전 방향
    
     반환값 : moves의 index, 즉 방향 변환된 이후의 방향
     */
    if direction == "L" {
        return (currDirection + 3) % 4
    } else {
        return (currDirection + 1) % 4
    }
}

var currDirection = 0 // 현재 뱀이 보고 있는 방향
var time = 0 // 현재까지의 시간
var y = 1 // 뱀의 머리 y좌표
var x = 1 // 뱀의 머리 x좌표
var turnIndex = 0 // 방향 전환 배열에서 값을 가져오기 위한 index값
var snakes = [(y, x)] // 뱀의 위치를 담는 배열, 새로 들어오는 값들이 머리가 된다.
board[y][x] = snake // 시작시 뱀위치 입력해놓기
while true {
    
    let ny = y + moves[currDirection].0 // 해당 방향으로 갔을 시에 다음 뱀이 향할 곳의 y좌표
    let nx = x + moves[currDirection].1 // 해당 방향으로 갔을 시에 다음 뱀이 향할 곳의 x좌표
    
    if 1 <= ny && ny <= N && 1 <= nx && nx <= N && board[ny][nx] != snake { // 다음 행선지가 범위 안에 있고, 뱀의 몸 부분이 아니라면??
        
        if board[ny][nx] == apple { // 다음 행선지가 '사과'라면
            board[ny][nx] = snake // 다음 행선지를 snake, 뱀으로 바꾸고
            snakes.append((ny, nx)) // snakes배열에 추가해준다.
        } else { // 다음 행선지가 그냥 공간이라면
            let tmp = snakes.removeFirst() // snakes의 새로 append되는 뒤 쪽이 머리이므로, 맨 앞에서 제거해준다.
            board[tmp.0][tmp.1] = 0 // 제거해온 좌표값을 다시 빈 공간으로 만들어주고
            board[ny][nx] = snake // 다음 행선지는 뱀으로 바꿔준다.
            snakes.append((ny, nx)) // 뱀으로 바꾼 부분을 snakes배열에 넣어준다.
        }
        
        y = ny // 뱀의 머리를 업데이트 해준다.
        x = nx //
        
        time += 1 // 시간을 1증가 시킨다.
        if turnIndex < L && time == turns[turnIndex].time { // turnIndex, turn배열에 쓰일 인덱스가 L(횟수보다) 작고 (index range) 현재 시간이 방향 전환을 지시하는 시간과 같다면??
            currDirection = turn(currDirection: currDirection, direction: turns[turnIndex].direction) // 현재 방향을 바꿔준다.
            turnIndex += 1 // 다음 방향 지시를 가리키기 위해 turnIndex값을 1 증가시킨다.
        }
        
    } else { // 다음 행선지가 범위 밖에 있거나(뱍에 부딫힘) 뱀의 몸 부분이라면
        time += 1 // 시간을 1 증가하고
        break // 종료시킨다.
    }
    
}

print(time) // 정답값 time을 출력한다.

func drawBoard() {
    for i in 1..<N+1 {
        for j in 1..<N+1 {
            print(board[i][j], terminator: " ")
        }
        print()
    }
}
