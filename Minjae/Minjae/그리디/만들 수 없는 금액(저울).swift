//
//  만들 수 없는 금액(저울).swift
//  Minjae
//  백준 2437 저울이랑 동일한 문제
//  Created by 김민재 on 2023/01/30.
//

import Foundation

let N = Int(readLine()!)!
var nums = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
// 무게추들을 오름차순으로 정렬, 만들 수 없는 최소 금액을 찾는 것이기 때문에 작은 것 부터 탐색
var accu = 1 // 누적합,
for num in nums {
    if num > accu { // 새로 추가되는 무게추가 지금까지의 누적합보다 크다면, 연속되지 않고 공백이 생긴다는 것이므로 여기서 break
        break
    }
    // 만약 새로 추가되는 무게추가 누적합보다 작다면 연속적으로 이어진다는 것이기 때문에 누적합에 해당 무게추의 무게를 더하면, 무게를 잴 수 있는 최고 무게가 계산된다.
    accu += num
}
print(accu) // 누적합이 초기에 1로 시작했기 때문에 바로 출력하면 정답값이 된다.


// https://aerocode.net/392 위가 헷가린다면 해당 링크에서 다시 보고 공부하자
