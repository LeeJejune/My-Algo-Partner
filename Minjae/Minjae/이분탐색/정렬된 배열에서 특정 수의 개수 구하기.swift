//
//  정렬된 배열에서 특정 수의 개수 구하기.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/13.
//

import Foundation



let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0]
let x = input[1]
let nums = readLine()!.split(separator: " ").map { Int($0)! }

func solution1() { // 첫번째 풀이 -> 답은 맞게 나오지만 O (n log n)의 시간복잡도라 안될 것이다.
    func binarySearch(array: [Int], target: Int, start: Int, end: Int) {
        // O (N log N) 이니까 안될듯
        var start = start
        var end = end
        var count = 0
        while start <= end {
            let mid = (start + end) / 2
            
            if array[mid] == target { // target을 찾았을 때
                
                count += 1
                
                var tmp = mid - 1
                while tmp >= 0 && array[tmp] == target { // 왼쪽으로 나아가면서 다른 수가 나올 때까지 cnt를 증가시키면서 나아가기
                    count += 1
                    tmp -= 1
                }
                
                tmp = mid + 1
                while tmp < N && array[tmp] == target { // 반대로 오른쪽으로 나아가기
                    count += 1
                    tmp += 1
                }
                break
            }
            
            if array[mid] < target {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        print(count == 0 ? -1 : count)
    }

    binarySearch(array: nums, target: x, start: 0, end: N - 1)
}


func solution2() {
    func first(array: [Int], target: Int, start: Int, end: Int) -> Int { // Target의 가장 첫번째 인덱스
        var start = start
        var end = end
        while start <= end {
            let mid = (start + end) / 2
            
            // Target가 같으면서도, 맨 앞이거나, 앞의 수가 target보다 작다(즉 같은 숫자 끝)면 mid 리턴
            // Target의 가장 첫번째 인덱스
            if (mid == 0 || target > array[mid - 1])  && array[mid] == target {
                return mid
            }
            
            if target <= array[mid] { // 작거나 같다면! 왼쪽으로 이동 (같다면 왼쪽으로 가야 첫번째 원소 찾을 수 있다)
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        return -1
    }
    
    func last(array: [Int], target: Int, start: Int, end: Int) -> Int { // Target의 가장 마지막 인덱스
        var start = start
        var end = end
        while start <= end {
            let mid = (start + end) / 2
            
            // Target과 같으면서, 맨 마지막 값이거나, 다음 값이 target보다 작다, 즉 다른 수가 온다면 Target의 마지막 인덱스
            if (mid == array.count - 1 || target < array[mid + 1])  && array[mid] == target {
                return mid
            }
            
            if target >= array[mid] { // 크거나 같다면! 오른으로 이동 (같다면 오른쪽으로 가야 마지막 원소 찾을 수 있다)
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        return -1
    }
    var answer = -1
    let first = first(array: nums, target: x, start: 0, end: nums.count - 1)
    if first > 0 { // 첫번째 원소가 -1이 나온다면, 아예 존재하지 않는 다는 것이기 때문에 last를 구할필요 없이 -1출력
        let last = last(array: nums, target: x, start: 0, end: nums.count - 1) // 첫번째 원소에 값이 있다면, Target의 마지막 위치도 확인
        answer = last - first + 1 // 마지막 인덱스 - 첫번째 인덱스 + 1
    }
    print(answer) // 정답 출력하기
}

solution2()
