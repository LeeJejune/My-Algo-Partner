//
//  공유기 설치.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/17.
//

import Foundation

// 서로 다른 좌표
// C개의 공유기를 N개의 집에 적당히 설치해서, 가장 인접한 두 공유기 사이의 거리를 최대로
let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0]
let C = input[1]

var house: [Int] = []
for _ in 0..<N {
    house.append(Int(readLine()!)!)
}
house.sort() // 이진탐색을 위한 정렬 O(NlogN)


var start = 1 // gap의 최소
var end = house[house.count - 1] - house[0] // gap의 최대
var answer = 0 // 정답값

while start <= end {
    let mid = (start + end) / 2 // Gap의 중간점, 중간 gap
    var count = 1 // 첫번째 위치에 공유기를 설치하고 나아간다
    var prev = house[0] // 첫번째 값
    
    // 앞에서부터 와이파이 설치
    for i in 1..<house.count {
        if house[i] >= prev + mid { // 공유기 설치한 위치 + gap 보다 같거나 크다면 공유기 설치 가능
            prev = house[i] // 공유기 설치하기
            count += 1 // 설치 개수 + 1
        }
    }
    // 만약 C이상으로 설치가 가능했더라면??
    if count >= C {
        start = mid + 1 // gap 늘려보기
        answer = mid // 정답 갱신
    } else { // 만약 C만큼 설치도 못했다? 그럼 gap을 줄여야한다
        end = mid - 1
    }
}
print(answer)

