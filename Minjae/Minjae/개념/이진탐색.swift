//
//  main.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/07.
//

import Foundation

// 이진탐색 재귀버전
func binarySearch(array: [Int], target: Int, start: Int, end: Int) -> Int? {
    if start > end {
        return nil
    }
    
    let mid = (start + end) / 2
    if array[mid] == target {
        return mid
    }
    // 중간점의 값보다 찾고자 하는 값이 작은 경우 왼쪽 확인
    else if array[mid] > target {
        return binarySearch(array: array, target: target, start: start, end: mid - 1)
    } else { // 큰 경우에는 오른쪽확인
        return binarySearch(array: array, target: target, start: mid + 1, end: end)
    }
}

// 반복문을 활용한 이진탐색
func binarySearchIter(array: [Int], target: Int, start: Int, end: Int) -> Int? {
    var start = start
    var end = end
    while start <= end {
        let mid = (start + end) / 2
        
        // 중간점이 target보다 크다? 왼쪽 확인
        if array[mid] > target {
            end = mid - 1
        } else if array[mid] < target { // 중간점이 타켓보다 작다? 오른쪽 확인
            start = mid + 1
        } else { // 찾았다
            return mid
        }
    }
    
    return nil // 못찾았다
}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0]
let target = input[1]

var array = readLine()!.split(separator: " ").map { Int($0)! }

let result = binarySearch(array: array, target: target, start: 0, end: N - 1)
let result2 = binarySearchIter(array: array, target: target, start: 0, end: N - 1)

if let result = result {
    print(result)
} else {
    print("없어요")
}


if let result2 = result2 {
    print(result2)
} else {
    print("이것도 없어요")
}
