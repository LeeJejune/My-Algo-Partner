//
//  1로 만들기.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/27.
//

import Foundation

/*
 
 */

let x = Int(readLine()!)!

var dp = [Int](repeating: 0, count: x+1) // DP 테이블

// dp[1], 1이 되기 위해 필요한 연산횟수는 0이므로 0으로 초기화하고 2부터 시작
// d[i]: i가 1이 되기 위해 필요한 최소한의 연산 횟수
for i in 2...x {
    
    dp[i] = dp[i-1] + 1 // dp[i-1](i-1이 1이 되기 위해 필요한 연산 횟수) + 1(i가 1을 빼서 i-1이 되기 위해 필요한 연산 횟수 1회)
    
    if dp[i] % 5 == 0 { // 5로 나눠질 경우
        dp[i] = min(dp[i], dp[i / 5] + 1) // i가 되기 위해 필요한 최소 연산, i/5가 1이 되기 위해 필요한 최소 연산 + i가 i/5되기 위해 필요한 나누기 5연산 1회 중 더 작은 값을 DP테이블에 저장.
    }
    
    if dp[i] % 3 == 0 { // 3으로 나눠질 경우
        dp[i] = min(dp[i], dp[i / 3] + 1) // 위와 동일한 과정을 3으로 나뉘것만 바뀜
    }
    
    if dp[i] % 2 == 0 { // 2로 나눠질 경우
        dp[i] = min(dp[i], dp[i / 2] + 1) // 여기도 마찬가지. 2로만 바뀜
    }
}

print(dp[x]) // 마지막에 x번째 인덱스, 즉 dp[x], dp[i]에는 i(x)가 1이 되기 위해 필요한 연산 횟수가 저장돼있다.
