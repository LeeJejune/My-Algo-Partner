//
//  치킨 배달.swift
//  algo
//
//  Created by 김민재 on 2023/01/03.
//

import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0] // 보드의 크기
let M = input[1] // 남길 치킨집 개수

var map: [[Int]] = [] // 지도 변수
for _ in 0..<N {
    map.append(readLine()!.split(separator: " ").map { Int($0)!}) // 지도 초기화
}

var chickens: [(Int, Int)] = [] // 치킨집의 위치를 (y, x)의 tuple형태로 받아서 저장하기 위한 변수
for i in 0..<N {
    for j in 0..<N {
        if map[i][j] == 2 { // 치킨집일 때
            chickens.append((i, j)) // 치킨집 배열에 저장한다
        }
    }
}

func calcDist(row: Int, col: Int, chickens: [(Int, Int)]) -> Int {
    /*
     집에서의 치킨 거리(치킨집 중에서의 가장 가까운 거리)를 구하는 함수
     
     row: 집일 때의 y값이 들어온다
     col: 집일 때의 x값이 들어온다
     chickens: 치킨집의 위치를 tuple로 담고 있는 배열
     
     return값: 집에서의 치킨 거리
     
     O(N)
     */
    var dist = 51
    for chicken in chickens { // 치킨집을 하나씩 돌면서
        dist = min(dist, abs(row - chicken.0) + abs(col - chicken.1)) // 가장 작은 치킨 거리를 찾는다
    }
    return dist // 치킨 거리 return
}


var answer = 10000 // 정답값을 출력하기 위해 초기값은 큰 값으로 넣어준다

var indexes: [[Int]] = [] // 조합으로, [chickens의 인덱스를 담고 있는 배열]의 배열
func combi(start: Int, nums: [Int]) {
    /*
     조합(Combination) 함수
     start: 인덱스
     nums: 인덱스의 배열
     
     */
    var nums = nums
    if nums.count == M { // Base Case: 인덱스의 배열이 목표 M개가 되었을 때
        indexes.append(nums) // indexes에 배열을 추가하고 return
        return
    }
    
    for i in start+1..<chickens.count { // for문을 돌면서 start 다음부터 끝까지 순회하면서
        nums.append(i) // start+1한 값을 더하고 (하나 select한거임)
        combi(start: i, nums: nums) // 재귀 호출, 다음 단계로 넘어감
        nums.popLast() // 다시 popLast로 마지막값을 빼서 상태 복원 !
    }
    return
}

combi(start: -1, nums: []) // start+1 해주면 0이 되기 때문에 -1을 넣어주면서 시작

for index in indexes { // 치킨집의 개수를 t라고 할 때, tCm 한 인덱스의 배열들이 담겨있기 때문에 해당 for문을 순회하면서
    // tCm
    // index: [Int], 선택된 M개의 인덱스가 담긴 배열, 해당 배열로 치킨집의 위치를 가져오면 된다
    var tmp: [(Int, Int)] = [] // 치킨집의 위치를 새로 담을 배열
    
    for idx in index { // M개의 인덱스가 담긴 배열을 순회하면서
        tmp.append(chickens[idx]) // 새로 선택된 M개의 치킨집들을 저장한다
    }
    
    var anstmp = 0 // 도시의 치킨거리를 담을 변수
    for row in 0..<N { // map을 전체 순회하면서 도시의 치킨거리를 구한다.
        for col in 0..<N {
            if map[row][col] == 1 { // 집일 경우
                anstmp += calcDist(row: row, col: col, chickens: tmp) // anstmp에 해당집의 치킨거리를 더한다
            }
        }
    }
    answer = min(answer, anstmp) // 답은 가장 작은 치킨거리를 출력해야한다
}

print(answer) // 정답값 출력


//func comb(nums: [(Int, Int)], visited: [Bool], depth: Int, n: Int, r: Int) {
//    var visited = visited
//    if r == 0 {
//
//        for i in 0..<visited.count {
//            if visited[i] {
//                tmp.append(chickens[i])
//            }
//        }
//        return
//    }
//    if depth == n {
//        return
//    }
//
//    visited[depth] = true
//    comb(nums: nums, visited: visited, depth: depth+1, n: n, r: r-1)
//
//    visited[depth] = false
//    comb(nums: nums, visited: visited, depth: depth+1, n: n, r: r)
//}
//
//comb(nums: chickens, visited: visited, depth: 0, n: chickens.count, r: M)
//
//
//var minDist = 10000
//for i in stride(from: 0, to: tmp.count, by: M) {
//    let chick = Array(tmp[i..<i+M])
//
//    var tmp = 0
//    for row in 0..<N {
//        for col in 0..<N {
//            if map[row][col] == 1 {
//                tmp += calcDist(row: row, col: col, chickens: chick)
//            }
//        }
//    }
//    minDist = min(minDist, tmp)
//}
//print(minDist)
// 치킨집 들 중에 M개를 고르는
// or
// 치킨집(t) 중에 폐업시킬 m-t개를 골라서 해당 거리만큼 빼기
// 뺀 값 계산한 치킨거리들 중에 최소값 구하기

// 조합 문제
//

/*
 
 조합 문제 아님??
 치킨집 개수 t C m 해서 이 중 치킨거리가 최소인 걸 구하는 거 아님?
 
 
 
 
 */

