//
//  효율적인 화폐 구성.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/27.
//

import Foundation


let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0] // N종류의 화폐
let M = input[1] // M원이 되게끔

var money: [Int] = [] // 화폐들
for _ in 0..<N {
    money.append(Int(readLine()!)!)
}


var dp = [Int](repeating: 10001, count: M + 1) // DP테이블, 최대 10000원이므로 10001로 초기화
// dp[i]: i원을 만드는데 필요한 최소 화폐 개수
dp[0] = 0 // 0원을 만들 방법은 없으므로 0

for m in money { // 화폐를 작은 화폐단위부터
    if m <= M { // m이 M보다 크면 에러가 나기 때문에 if문 추가
        for i in m...M { // 화폐단위 시작부터 목표 M까지
            dp[i] = min(dp[i], dp[i-m] + 1) //
            // dp[i-m]: (i-m)원을 만드는데 필요한 최소 화폐 개수 + 1(i-m에서 i를 만드는데 필요한 화폐 개수 1개, m원짜리 하나)
        }
    }
}

if dp[M] == 10001 { // 10001은 만들 수 없는 금액임을 의미
    print(-1) // -1
} else {
    print(dp[M]) // 인덱스 M, M원을 만드는데 필요한 최소 화폐 개수 출력
}

