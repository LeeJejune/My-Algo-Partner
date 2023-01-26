//
//  연산자 끼워넣기.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/26.
//

import Foundation

let N = Int(readLine()!)! // 수의 개수 N
let A = readLine()!.split(separator: " ").map { Int($0)! } // 수열

let input = readLine()!.split(separator: " ").map { Int($0)! }
let plusCount = input[0] // 덧셈 개수
let subCount = input[1] // 뺄셈 개수
let multiCount = input[2] // 곱셈 개수
let divCount = input[3] // 나눗셈 개수

var tmp = "" // 주어진 개수대로 나열하기 위한 임의의 문자열
for _ in 0..<plusCount { // 덧셈 개수만큼 문자열에 + 추가
    tmp.append("+")
}

for _ in 0..<subCount { // 덧셈 개수만큼 문자열에 - 추가
    tmp.append("-")
}

for _ in 0..<multiCount { // 덧셈 개수만큼 문자열에 * 추가
    tmp.append("*")
}

for _ in 0..<divCount { // 덧셈 개수만큼 문자열에 / 추가
    tmp.append("/")
}

var ops: [String] = [] // 순열로 뽑은 경우들을 모두 담을 배열

var tmpArr = Array(tmp) // swapAt, 순서를 바꿔가기 위해 문자열보다 편리한 배열로 형변환해서 순열을 시켜준다.

// 순열 구현하기
func permu(n: Int, r: Int, depth: Int) {
    
    if depth == r {
        // logic
        ops.append(String(tmpArr))
        return
    }
    
    for i in depth..<n {
        tmpArr.swapAt(i, depth)
        permu(n: n, r: r, depth: depth + 1)
        tmpArr.swapAt(i, depth)
    }
}

// 한가지 경우 밖에 없는 경우는 순열을 돌릴 필요없이 바로 계산하면 되므로 아래와 같이 나눠서 계산한다
if tmp.count == plusCount { // 주어진 모든 경우가 덧셈한가지 밖에 없을 경우
    print(A.reduce(0, +))
    print(A.reduce(0, +))
} else if tmp.count == subCount { // 모든 경우가 뺄셈
    var tmp = A[0]
    for i in 1..<A.count {
        tmp -= A[i]
    }
    print(tmp)
    print(tmp)
} else if tmp.count == multiCount { // 모든 경우가 곱셈
    var tmp = A[0]
    for i in 1..<A.count {
        tmp *= A[i]
    }
    print(tmp)
    print(tmp)
} else if tmp.count == divCount { // 모든 경우가 나눗셈
    var tmp = A[0]
    for i in 1..<A.count {
        tmp /= A[i]
    }
    print(tmp)
    print(tmp)
} else { // 여러가지 연산이 섞인 경우에는 순열을 진행
    permu(n: tmp.count, r: N-1, depth: 0) // 순열 실행
    
    ops = Array(Set(ops)) // 순열을 하게되면 "+-+"이러한 문자열에서 +를 두가지 모두 다른 경우로 보기 때문에 Set을 통해 중복을 제거한 후 다시 배열로 형변환시켜준다
    var accu = A[0] // 계산 결과 누적기
    var answer: [Int] = [] // 계산 결과 값들을 담을 배열
    for op in ops { // 순열을 통해 계산된 문자열들
        
        for (idx, i) in op.enumerated() { // 문자열들을 하나씩 누적기에 계산해나간다
            if i == "+" { // 덧셈
                accu += A[idx + 1] // 수열의 개수는 N, 사이에 들어가는 연산자의 개수는 N-1이므로 idx+1을 해준다
            } else if i == "-" { // 뺄셈
                accu -= A[idx + 1]
            } else if i == "*" { // 곱셈
                accu *= A[idx + 1]
            } else { // 나눗셈
                accu /= A[idx + 1]
            }
        }
        
        answer.append(accu) // 마지막에 계산한 결과값을 answer배열에 담는다
        accu = A[0] // 누적기 A[0]으로 초기화
    }

    print(answer.max()!) // 저장한 결과값들 중 max값
    print(answer.min()!) // 저장한 결과값들 중 min값
}
