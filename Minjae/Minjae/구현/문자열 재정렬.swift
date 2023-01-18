//
//  문자열 재정렬.swift
//  algo
//
//  Created by 김민재 on 2022/12/21.
//

import Foundation

let input = readLine()!
var charArr: [String] = []
var numArr: [Int] = []
for i in input {
    if i.isLetter {
        charArr.append(String(i))
    } else if i.isNumber {
        numArr.append(Int(String(i))!)
    }
}
charArr.sort()
let num = String(numArr.reduce(0, +))
charArr.append(num)
print(charArr.joined())

/*
 처음에는 숫자들을 나열해서 보여줘야하는지 알고 numArr에 num을 저장했지만
 합을 보여주는 것이라면 numArr를 만들 필요없이 그냥 sum 변수 하나를 만들어놓고 거기에 값을 더해주고, 최종값을 String으로 바꿔서
 출력해주면 될듯
 */
