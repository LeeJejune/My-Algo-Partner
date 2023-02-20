//
//  고정점 찾기.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/14.
//

import Foundation

let N = Int(readLine()!)! // N개의
let array = readLine()!.split(separator: " ").map { Int($0)! } // 서로 다른! 원소 N개

func binarySearch(array: [Int], start: Int, end: Int) {
    var start = start
    var end = end
    while start <= end {
        let mid = (start + end) / 2
        
        if array[mid] == mid { // 인덱스와 해당 인덱스 위치의 값이 일치한다면, 고정점 찾은 것
            print(mid) // 출력하고 return
            return
        }
        
        if mid < array[mid] { // 인덱스보다 값이 크다면??
            end = mid - 1
            /*
             왼쪽(작은쪽) 탐색. WHY??
             오름차순으로 정렬돼있기 때문.
             예시를 들어보자 !
             -15 -4 2 8 9 13 15
              0   1 2 3 4  5  6
             첫번째 단계를 진행해보면 알 수 있다.
             중간점(mid) 3은, array[mid] 8보다 작다.
             수열은 오름차순으로 정렬돼있기 때문에, array[3]의 다음값들은 모두 9이상의 수들이다.
             그렇게 되면 오른쪽은 절대 mid==array[mid]가 될 수 없기 때문에 배제해도 된다.
             따라서 왼쪽을 탐색한다.
             */
        } else {
            start = mid + 1 // 이는 위와 정확히 반대의 상황이다.
        }
    }
    print(-1) // 위의 while문안에서 return되지 않았다면 고정점을 못찾은것이므로 -1 출력
}

binarySearch(array: array, start: 0, end: array.count - 1)




// 해설참고: https://blex.me/@mildsalmon/%EC%9D%B4%EC%B7%A8%EC%BD%94-chap-15-%EC%9D%B4%EC%A7%84%ED%83%90%EC%83%89-%EA%B3%A0%EC%A0%95%EC%A0%90-%EC%B0%BE%EA%B8%B0
