//
//  main.swift
//  algo
//
//  Created by 김민재 on 2023/01/12.
//

import Foundation

func solution(_ n:Int, _ weak:[Int], _ dist:[Int]) -> Int {
    
    // circular를 위해 배열을 2배로 확장해서 일차원 배열로 표현하기
    var weak = weak // [1, 3, 4, 9, 10]
    let length = weak.count
    for i in 0..<length {
        weak.append(weak[i] + n) // [1, 3, 4, 9, 10, 13, 15, 16,..., 22]
    }
    
    // permutation 순열로 친구 배치가능한 경우 전부 확인하기
    var dist = dist
    var permus: [[Int]] = []
    func permu(n: Int, r: Int, depth: Int) {
        if r == depth {
            permus.append(dist)
            return
        }
        
        for i in depth..<n {
            dist.swapAt(i, depth)
            permu(n: n, r: r, depth: depth + 1)
            dist.swapAt(i, depth) // 상태 복원
        }
        return
    }
    
    permu(n: dist.count, r: dist.count, depth: 0)
    
    var answer = dist.count + 1
    // 시작점 설정, 0부터 weak.count - 1을 시작점으로..
    for start in 0..<length {
        
        for permu in permus { // 친구들 배치 순열
            
            var count = 1 // 현재 투입된 친구의 수, 시작 기본 1명
            var position = weak[start] + permu[count - 1] // 친구가 갈 수 있는 마지막 위치
            
            for index in start..<start + length { // 시작..<시작 + weak.count
                
                if position < weak[index] { // 친구가 갈 수 있는 마지막 위치에서 벗어난다면?
                    count += 1 // 친구 한명 더 투입
                    if count > dist.count { // 한명 더 투입한 count가 주어진 친구 수보다 많다면 -> break
                        break
                    }
                    position = weak[index] + permu[count - 1] // 친구한명 더 투입하고, 해당 친구가 마지막으로 갈 수 있는 position update
                }
            }
            answer = min(answer, count) // 친구 순열의 한 부분이 끝나면 answer를 최소화된 count가 나오게끔 update
        }
    }
    
    if answer > dist.count { // 친구를 모두 투입했다면 count = dist.count + 1이 될텐데, 이러면 answer도 동일, 이 때는 모두 투입해도 커버불가능이니까 -1
        return -1
    }
    return answer // 그렇지 않다면 answer return
}

print(
    solution(12, [1, 5, 6, 10]    , [1, 2, 3, 4]    )
)
print(solution(12, [1, 3, 4, 9, 10]    , [3, 5, 7]    ))
