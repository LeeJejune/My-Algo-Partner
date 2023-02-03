//
//  볼링공 고르기.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/30.
//

import Foundation

// 내 풀이
func solution1() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let N = input[0]
    let M = input[1]

    let weights = readLine()!.split(separator: " ").map { Int($0)! }
    
    
    var count = 0 // 경우의 수를 담을 정답 변수
    
    // 무게가 같아도 번호(인덱스)가 다르면 다른 볼링공이다. 따라서 2중 for문으로 inner-루프는 outer루프의 다음번부터 탐색 시작, 다음번부터 탐색하는 이유는 조합이기 때문에
    for i in 0..<weights.count {
        let selected = weights[i] // A가 고른 볼링공
        for j in i+1..<weights.count { // A가 고른 볼링공의 다음부터 탐색 시작
            if weights[j] != selected { // A가 고른 볼링공과 무게가 다르다면??
                count += 1 // 경우의 수, count 1증가
            }
        }
    }

    print(count)
}

// 해답풀이
func solution2() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    var N = input[0] // 볼링공 개수
    let M = input[1] // 볼링공 최대 무게

    let weights = readLine()!.split(separator: " ").map { Int($0)! } // 볼링공 무게들 입력받기
    
    var weightCnt = [Int](repeating: 0, count: weights.count + 1) // 볼링공 개수를 담기 위한 배열(idx: 볼링공 무게, weight[idx]: 해당 무게의 볼링공 개수
    for weight in weights {
        weightCnt[weight] += 1
    }
    
    
    var answer = 0
    for i in 1...M { // A가 고르는 볼링공의 무게, 작은 무게부터 고른다
        N -= weightCnt[i] // 전체 볼링공 개수(N)에서 A가 고른 무게의 개수를 빼면, B가 고를 수 있는 다른 무게의 볼링공들의 개수, 즉 B가 고를 수 있는 경우의 수가 나온다
        answer += weightCnt[i] * N // A가 고른 무게의 볼링공 개수, 즉 A가 고를 수 있는 경우의 수 * N(B가 고를 수 있는 경우의 수)를 정답 변수에 더해준다.
    }
    print(answer) // 정답값 출력
}


solution2()
