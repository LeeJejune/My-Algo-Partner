//
//  main.swift
//  algo
//
//  Created by 김민재 on 2022/12/29.
//

import Foundation

/*
 기둥이 가능한 경우
 - 바닥 위
 - 보의 한쪽 끝 부분 위
 - 다른 기둥 위
 
 보가 가능한 경우
 - 한쪽 끝 부분이 기둥 위
 - 양쪽 끝 부분이 다른 보와 동시에 연결돼있어야
 */

func possible(_ answer: Set<[Int]>) -> Bool {
    for ans in answer {
        let x = ans[0]
        let y = ans[1]
        let a = ans[2] // 0은 기둥, 1은 보
        
        if a == 0 { // 기둥
            
            if y == 0 ||
                (answer.contains([x - 1, y, 1]) || answer.contains([x, y, 1])) ||
                answer.contains([x, y - 1, 0]) {
                continue
            }
            return false
            
        } else { // 보
            
            if y != 0 &&
                (answer.contains([x, y - 1, 0]) || answer.contains([x + 1, y - 1, 0])) ||
                (answer.contains([x - 1, y, 1]) && answer.contains([x + 1, y, 1])) {
                continue
            }
            return false
        }
    }
    return true
}

func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] {
    
    var answers = Set<[Int]>()
    
    for frame in build_frame {
        let x = frame[0]
        let y = frame[1]
        let a = frame[2] // 0은 기둥, 1은 보
        let b = frame[3] // 0은 삭제, 1은 설치
        
        if b == 0 { // 삭제하는거면
            answers.remove([x, y, a])
            
            if !possible(answers) {
                answers.insert([x, y, a])
            }
        } else { // 설치
            answers.insert([x, y, a])
            
            if !possible(answers) {
                answers.remove([x, y, a])
            }
        }
    }
    
    let tmp = Array(answers).sorted { a, b in
        if a[0] == b[0] {
            if a[1] == b[1] {
                return a[2] < b[2]
            }
            return a[1] < b[1]
        }
        return a[0] < b[0]
    }
    
    return tmp
}

