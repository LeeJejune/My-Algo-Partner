//
//  떡볶이 떡 만들기.swift
//  Minjae
//  https://www.acmicpc.net/problem/2805 나무자르기 문제와 동일.
//  Created by 김민재 on 2023/02/10.
//

import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let N = input[0] // 떡의 개수 N
let M = input[1] // 손님이 원하는 떡의 길이, 적어도! M만큼 가져간다.

var dduk = readLine()!.split(separator: " ").map { Int($0)! } // 떡 길이 입력받기

var answer = 0 // 절단기 높이를 담을 변수
// 이진탐색 함수
func cutD(array: [Int], target: Int, start: Int, end: Int) {
    /*
     array: 떡의 길이를 담은 배열
     target: M
     start: 0
     end: 가진 떡 중 가장 긴 떡
     당연히 절단기의 높이는 0~가장 긴 떡의 길이 중에서 골라야한다.
     */
    var start = start
    var end = end
    while start <= end {
        let mid = (start + end) / 2 // 중간점 설정
        
        var total = 0 // 중간점을 기준으로 잘려나가고 남은 떡들의 길이 합
        for a in array {
            if a > mid { // 중간점보다 긴 떡들은
                total += (a - mid) // 남은 떡 길이들을 더한다
            }
        }
        
        if total < target { // 만약 남은 떡 길이가 target보다 작다면??
            end = mid - 1 // 더 길게 잘라야한다는 것이기 때문에, 왼쪽 확인
        } else { // target보다 크다면, 즉 충본히 잘랐다면?
            start = mid + 1 // 더 적게 잘라야하니 오른쪽으로 이동
            answer = mid // 요구하는 정답은 절단기 높이의 최댓값이기 때문에 여기서 답을 계속해서 갱신해나간다.
            
        }
    }
}

cutD(array: dduk, target: M, start: 0, end: dduk.max()!)
print(answer)

/*
 기존에 target을 딱 맞췄을 때만 답을 return했는데, 알고보니 적어도! M만큼의 떡을 가져가는 것이었다.
 백준 질문 게시판을 보고 반례를 찾았고, 문제에 "적어도"라는 것을 그제서야 발견했다. 문제를 꼼꼼히 읽도록 하자...
 반례:
 2 3
 3 3
 딱 M만큼 가져가게 되리란 보장은 없다
 */
 
