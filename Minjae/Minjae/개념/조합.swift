//
//  main.swift
//  algo
//
//  Created by 김민재 on 2023/01/03.
//

import Foundation

let n = 5
let k = 3
var a = [1, 2, 3, 4, 5]
func combi(start: Int, b: [Int]) {
    var b = b
    if b.count == k {
        print(b)
        return
    }
    
    for i in start+1..<n {
        b.append(i)
        combi(start: i, b: b)
        b.popLast()
    }
    return
}

var ans: [Int] = []
combi(start: -1, b: ans)
