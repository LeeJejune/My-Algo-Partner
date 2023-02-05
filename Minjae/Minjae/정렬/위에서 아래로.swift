//
//  위에서 아래로.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/05.
//

import Foundation

let n = Int(readLine()!)!
var arr: [Int] = []
for _ in 0..<n {
    arr.append(Int(readLine()!)!)
}
print(arr.sorted(by: { a, b in
    return a > b
}))
