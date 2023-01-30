//
//  감시 피하기.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/26.
//

import Foundation

let N = Int(readLine()!)! // 보드크기 NxN 입력받기

var board: [[String]] = [] // 복도 입력받기
for _ in 0..<N {
    let input = readLine()!.split(separator: " ").map { String($0) }
    board.append(input)
}

var xSpaces: [(Int, Int)] = [] // 빈칸들의 위치 따로 모아놓을 배열
for i in 0..<N {
    for j in 0..<N {
        if board[i][j] == "X" {
            xSpaces.append((i, j))
        }
    }
}


var combiSpaces: [[(Int, Int)]] = [] // 빈칸들에 벽 3개를 설치하는 경우의 수 (조합)

// 조합 구현하기
func combi(start: Int, b: [Int]) {
    var b = b
    if b.count == 3 {
        var tmp: [(Int, Int)] = []
        for i in b {
            tmp.append(xSpaces[i])
        }
        combiSpaces.append(tmp)
        return
    }
    
    for i in start + 1..<xSpaces.count {
        b.append(i)
        combi(start: i, b: b)
        b.popLast()
    }
}

combi(start: -1, b: []) // 조합 실행

func checkStudent(y: Int, x: Int) -> Bool {\
    /*
     (y, x): 선생님 위치 인자로 받기
     -------
     선생님이 학생을 찾는다면 true
     못찾는다면 false
     */
    
    // 행 검사
    // -> 검사
    for i in x+1..<N {
        if board[y][i] == "O" {
            break
        } else if board[y][i] == "S" {
            return true
        }
    }
    
    // <- 검사
    for i in stride(from: x-1, through: 0, by: -1) {
        if board[y][i] == "O" {
            break
        } else if board[y][i] == "S" {
            return true
        }
    }
    
    // 열 검사
    // up 위 검사
    for i in stride(from: y-1, through: 0, by: -1) {
        if board[i][x] == "O" {
            break
        } else if board[i][x] == "S" {
            return true
        }
    }
    
    // down 아래 검사
    for i in y+1..<N {
        if board[i][x] == "O" {
            break
        } else if board[i][x] == "S" {
            return true
        }
    }
    return false
}

var flag = false // 학생들이 결과적으로 성공했다면 true로 바뀔 예정

for comb in combiSpaces { // 벽 3개 설치하는 경우들을 탐색하면서
    
    let tmp = board // 초기상태 저장
    
    // 장애물 벽세우기
    for com in comb {
        board[com.0][com.1] = "O"
    }

    var isSuccess = true // 학생들 성공? 실패?
    
outer: for i in 0..<N {
        for j in 0..<N {
            if board[i][j] == "T" {
                if checkStudent(y: i, x: j) { // 한명의 선생님이라도 학생을 찾으면?
                    isSuccess = false // 학생들 실패 !
                    break outer // break하고 다음 경우의 수로 넘어가자
                }
            }
        }
    }
    
    if isSuccess { // 한번이라도 성공한다면 더 이상 탐색할 필요없다
        flag = true // 전역변수 flag true로 바꾸고 break
        break
    }
    
    board = tmp // 초기 board 상태 복원
}

print(flag ? "YES" : "NO") // flag이 true라면 학생들 성공 아니라면 실패
