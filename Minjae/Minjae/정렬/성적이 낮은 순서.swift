//
//  성적이 낮은 순서로 학생 출력하기.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/05.
//

import Foundation

let N = Int(readLine()!)!

var arr: [(String, Int)] = []
for _ in 0..<N {
    let input = readLine()!.split(separator: " ")
    let name = String(input[0])
    let score = Int(input[1])!
    arr.append((name, score))
}

arr.sort { a, b in
    return a.1 < b.1
}
for i in arr {
    print(i.0, terminator: " ")
}
print()
