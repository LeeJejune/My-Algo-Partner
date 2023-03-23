//
//  정수삼각형.swift
//  Minjae
//
//  Created by 김민재 on 2023/03/22.
//

import Foundation

let n = Int(readLine()!)!
var dp: [[Int]] = []
for _ in 0..<n {
    dp.append(readLine()!.split(separator: " ").map({ Int($0)! }))
}

// dp[i][j] = array[i][j] + max(dp[i-1][j-1], dp[i-1][j])

for i in 1..<n {
    for j in 0...i {
        var upLeft = 0
        if j == 0 {
            upLeft = 0
        } else {
            upLeft = dp[i-1][j-1]
        }

        var up = 0
        if j == i {
            up = 0
        } else {
            up = dp[i - 1][j]
        }
        dp[i][j] = dp[i][j] + max(upLeft, up)
    }
}

print(dp[n-1].max()!)
