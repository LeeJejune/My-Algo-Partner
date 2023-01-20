//
//  럭키 스트레이트.swift
//  algo
//
//  Created by 김민재 on 2022/12/21.
//

import Foundation

let input = readLine()!.map { Int(String($0))! }
let half = input.count / 2
let firstHalf = input[0..<half].reduce(0, +)
let secondHalf = input[half...].reduce(0, +)
if firstHalf == secondHalf {
    print("LUCKY")
} else {
    print("READY")
}
