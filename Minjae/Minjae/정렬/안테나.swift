//
//  안테나.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/05.
//

import Foundation

let N = Int(readLine()!)!
var house = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
print(house[(house.count - 1) / 2])

// 중앙 위치에 있는 집에 안테나를 설치하는 것이 항상 최소합을 보장한다.
