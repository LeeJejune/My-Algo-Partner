//
//  문자열 뒤집기.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/30.
//

import Foundation

var S = readLine()!.map { Int(String($0))! }

var isZeroIn = S[0] == 0 ? false : true // 처음 시작이 0이라면 false, 1이라면 true

var group: [Int] = [] // 그룹별로 묶어서 적은 그룹을 뒤집는 것이 더 현명하다
for s in S {
    if s == 0 && !isZeroIn { // 0이며, 0이 다시 처음 나온 거라면?
        group.append(0) // group에 0을 넣고
        isZeroIn = true // flag값을 true로 바꾼다
    } else if s == 1 && isZeroIn { // 1이며, 지금까지 나온게 0이고, 1은 처음이라면??
        isZeroIn = false // flag를 false로 바꾸고
        group.append(1) // group에 1을 넣는다
    }
}
// group의 모습: [0, 1, 0]
var zeroCnt = 0 // 0의 그룹 수 세기
var oneCnt = 0 // 1의 그룹 수 세기
for i in group {
    if i == 0 {
        zeroCnt += 1
    } else {
        oneCnt += 1
    }
}

print(zeroCnt < oneCnt ? zeroCnt : oneCnt) // 더 적은 그룹 수 출력하기
