//
//  곱하기 혹은 더하기.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/30.
//

import Foundation

let str = readLine()!.map { Int(String($0))! }.sorted { a, b in
    return a > b
}


var accu = str[0]
for i in 1..<str.count {
    if str[i] == 0 {
        break
    } else if str[i] == 1 {
        accu += 1
    } else {
        accu *= str[i]
    }
}
print(accu)


