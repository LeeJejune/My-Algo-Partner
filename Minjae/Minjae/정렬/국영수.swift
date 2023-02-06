//
//  국영수.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/05.
//

import Foundation

// N이 최대 100,000까지 주어지기 때문에
// O(NlogN)의 알고리즘으로 설계하면 풀릴 것
// Swift에서의 sort은 O(n log n)을 보장해준다.
let N = Int(readLine()!)! // N명
var arr: [(String, Int, Int, Int)] = []
for _ in 0..<N {
    let input = readLine()!.split(separator: " ")
    let name = String(input[0])
    let korean = Int(input[1])!
    let english = Int(input[2])!
    let math = Int(input[3])!
    
    arr.append((name, korean, english, math)) // 튜플 형식으로 저장
}

arr.sort { a, b in // 조건에 맞게 정렬하기
    if a.1 == b.1 {
        if a.2 == b.2 {
            if a.3 == b.3 {
                return a.0 < b.0
            }
            return a.3 > b.3
        }
        return a.2 < b.2
    }
    return a.1 > b.1
}

for a in arr { // 이름만 출력하기
    print(a.0)
}


