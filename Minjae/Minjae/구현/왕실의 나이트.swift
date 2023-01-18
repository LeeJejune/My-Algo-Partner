//
//  왕실의 나이트.swift
//  algo
//
//  Created by 김민재 on 2022/12/21.
//

import Foundation

func changeCharToCol(str: String) -> Int { // INPUT "a1"에서 a를 col 숫자로 바꿔주기 위한 함수이다. -> Int
    // 문제에서 필요한 알파벳들을 담은 배열
    let char = ["a", "b", "c", "d", "e", "f", "g", "h"]
    return char.lastIndex(of: str)! // 배열에서 몇번째 index인지를 통해서 숫자로 바꿔 줄 것이다.
}


// 말이 갈 수 있는 이동 경로를 튜플형태로 담은 배열
// [UP-R, UP-L, RIGHT-UP, RIGHT-DOWN, DOWN-LEFT, DOWN-RIGHT, LEFT-UP, LEFT-DOWN]
var moves = [(-2, 1), (-2,-1), (-1, 2), (1, 2), (2, -1), (2, 1), (-1, -2), (1, -2)]

let input = readLine()! // "a1", 식으로 입력값 받는 것이다.
let col = changeCharToCol(str: String(input.first!))
// 입력받은 입력값에서 a는 그 자체로 활용하기 까다로우니 Int값으로 바꿔주었다.
let row = input.last!.wholeNumberValue! - 1
// row는 입력받는 문자를 숫자로 바꿔주었고 문제는 row가 1부터 시작이기 때문에 0번 인덱스부터 활용하기 위해 1을 빼주었다.


var answer = 0 // 정답값 출력을 위한 변수이다.
for move in moves { // 앞서 말이 갈 수 있는 이동경로를 모두 담은 배열을 한번씩 순회한다.
    let ny = move.0 // 튜플의 첫번째 값인 y값을 가져온다.
    let nx = move.1 // 튜플의 두번째 값인 x값을 가져온다.
    if row + ny > 7 || col + nx > 7 || row + ny < 0 || col + nx < 0 { // 입력받은 row, col에 이동경로의 row, col을 한번씩 더해보면서 다음 위치가 지도 안에 위치하는지 파악한다.
        continue // 범위를 벗어난다면 continue로 다음 이동 경로를 확인한다.
    }
    answer += 1 // 범위를 벗어나지 않았다면 answer를 1씩 증가시켜준다.
}

print(answer) // 모든 이동경로 탐색을 마친 후에 답을 출력한다.





