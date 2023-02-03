//
//  모험가길드.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/30.
//

import Foundation

func solution1() {
    let N = Int(readLine()!)!
    var fear = readLine()!.split(separator: " ").map { Int($0)! }

    var fearCount = fear.count
    var groupCnt = 0
    while fearCount > 0 {
        fearCount -= fear.max()!
        groupCnt += 1
    }
    print(groupCnt)
}

func solution2() {
    let N = Int(readLine()!)!
    var fear = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
    
    
    var groupCnt = 0 // 그룹의 수
    
    var count = 0 // 현재 그룹에 속한 모험가의 수
    for i in fear { // 오름차순으로 정렬된 공포도를 탐색하면서
        count += 1 // 그룹에 모험가 추가
        if count >= i { // 그룹 형성조건이 채워졌다면
            groupCnt += 1 // 그룹 만들기
            count = 0 // 그룹 구성원 수는 다시 0으로, 새로운 그룹 만들자
        }
    }
    print(groupCnt)
}
