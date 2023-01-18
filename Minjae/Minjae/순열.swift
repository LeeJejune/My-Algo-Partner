//
//  main.swift
//  algo
//
//  Created by 김민재 on 2023/01/09.
//

import Foundation

var v: [Int] = []

func permu(_ n:Int, _ r: Int, _ depth:Int) {
    /*
     순열
     nPr = n!/(n-r)!
     */
    if r == depth {
        // logic
        for i in 0..<v.count {
            print(v[i],terminator: " ")
        }
        print()
        return
    }
    
    for i in depth..<n {
        v.swapAt(i, depth)
        permu(n, r, depth + 1)
        v.swapAt(i, depth)
    }
    return
}

for i in 1...3 {
    v.append(i)
}

permu(3, 3, 0)
