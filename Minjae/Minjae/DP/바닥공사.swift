//
//  바닥공사.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/27.
//

import Foundation


let n = Int(readLine()!)!

var dp = [Int](repeating: 0, count: n+1)

dp[1] = 1 // 1만큼 채울 수 있는 건 2 x 1 하나.
dp[2] = 3 // 2만큼 채울 수 있는 건 ㅣㅣ ㅡㅡ(=) ㅁ 이렇게 3개

for i in 3...n { // 3부터 시작
    dp[i] = (dp[i-1] + dp[i-2] * 2) % 796796 // i-1인 상태에서는 하나밖에 세울게 없다
    // i-2인 상태에서는 =,ㅁ 이렇게 두가지 경우가 있으니 x 2
    // 위의 경우를 모두 더해서 모든 i일 때의 모든 경우의 수를 구한다.
}

print(dp[n])
