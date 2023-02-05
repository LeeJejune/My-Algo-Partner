//
//  두 배열의 원소 교체.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/05.
//

import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0] // N개의 수로 이루어진 배열
let K = input[1] // K번 바꿔치기 가능

var a = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
var b = readLine()!.split(separator: " ").map { Int($0)! }.sorted { a, b in
    return a > b
}

var count = 0
for i in 0..<a.count {
    if count == K {
        break
    }
    
    a[i] = b[count]
    count += 1
}
print(a.reduce(0, +))

