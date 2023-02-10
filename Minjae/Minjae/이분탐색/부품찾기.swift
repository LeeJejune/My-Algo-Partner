//
//  부품찾기.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/10.
//

import Foundation



func solution1() {
    let N = Int(readLine()!)!
    var have = Set(readLine()!.split(separator: " ").map { Int($0)! })
    let M = Int(readLine()!)!
    var want = readLine()!.split(separator: " ").map { Int($0)! }
    for w in want {
        if have.contains(w) {
            print("yes", terminator: " ")
        } else {
            print("no", terminator: " ")
        }
    }
    print()
}

// 이진 탐색
func solution2() {
    func binarySearch(array: [Int], target: Int, start: Int, end: Int) {
        var start = start
        var end = end
        while start <= end {
            var mid = (start + end) / 2
            if array[mid] == target {
                print("YES")
                return
            }
            
            if array[mid] > target { // 왼쪽확인
                end = mid - 1
            } else { // 오른쪽 확인
                start = mid + 1
            }
        }
        print("NO")
        return
    }
    let N = Int(readLine()!)!
    var have = readLine()!.split(separator: " ").map { Int($0)! }
    let M = Int(readLine()!)!
    var want = readLine()!.split(separator: " ").map { Int($0)! }
    
    for w in want {
        binarySearch(array: have, target: w, start: 0, end: have.count - 1)
    }
}

// 계수 정렬로 해당 인덱스의 값이 0보다 큰지만 확인하면됨
func solution3() {
    let N = Int(readLine()!)!
    var have = readLine()!.split(separator: " ").map { Int($0)! }
    var counts = [Int](repeating: 0, count: 1000001)
    for h in have {
        counts[h] += 1
    }
    
    let M = Int(readLine()!)!
    var want = readLine()!.split(separator: " ").map { Int($0)! }
    
    for w in want {
        if counts[w] > 0 {
            print("YES")
        } else {
            print("NO")
        }
    }
}

solution3()
