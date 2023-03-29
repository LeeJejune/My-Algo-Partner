//
//  개미 전사.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/27.
//

import Foundation

let n = Int(readLine()!)! // N개
var storage = readLine()!.split(separator: " ").map { Int($0)! } // 식량창고

/*
 인접한 창고는 털 수 없다. 최소 한칸은 띄워서 털어야한다
 그렇다면 창고를 털지 말지 결정하는 경우는 두가지
 1. 1칸전의 창고를 털고, 현재 창고는 털지 않는 경우
 2. 2칸전의 창고를 털고, 현재 창고를 터는 경우
 
 Note: 이 때, 3칸 뒤는 무조건 털 수 있기 때문에 고려하지 않는다. 이미 포함되어 있다
 위의 두가지 경우 중 큰 값을 선택하면 된다
*/

for i in 2..<n { // 바텀업
    // 초기 값 두개를 storage에서 그대로 가져와야하기 때문에, 그냥 기존에 있던 storage를 DP테이블로 활용함.
    storage[i] = max(storage[i - 1], storage[i - 2] + storage[i]) // 위의 두가지 경우를 비교해서 더 큰 값을 저장한다.
}
print(storage[n-1])


