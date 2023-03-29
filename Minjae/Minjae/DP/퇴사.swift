//
//  main.swift
//  Minjae
//
//  Created by 김민재 on 2023/03/28.
//

import Foundation

let n = Int(readLine()!)!

var work: [(Int, Int)] = []
var dp: [Int] = [Int](repeating: -1, count: n)
for _ in 0..<n {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let time = input[0] // 상담 걸리는 시간
    let pay = input[1] // 보수
    work.append((time, pay))
}

@discardableResult // top-down 방식
func recur(time: Int) -> Int {
    if time > n { return -999999999} // 퇴사일 넘으면 음수
    if time == n { return 0 } // 퇴사일 당일이면 0

    if dp[time] != -1 { // 이전값 있으면 그거 가져오기: 메모이제이션
        return dp[time]
    }

    dp[time] = max(
        recur(time: time + 1), // 일을 안 한 경우
        recur(time: time + work[time].0) + work[time].1 // 일을 한 경우
    )
    return dp[time]
}


recur(time: 0)
print(dp[0])


func sol() {
    let n = Int(readLine()!)!

    var work: [(Int, Int)] = []
    var dp = [Int](repeating: 0, count: n+1)
    for i in 0..<n {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let time = input[0]
        let pay = input[1]
        work.append((time, pay))
        dp[i] = pay
    }


    for i in stride(from: n-1, through: 0, by: -1) {
        let next = i + work[i].0
        if next > n {
            dp[i] = dp[i + 1]
        } else {
            dp[i] = max(dp[i+1], dp[next] + work[i].1)
        }
    }
    print(dp[0])
}
