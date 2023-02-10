//
//  실패율.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/06.
//

import Foundation

/*
 문제 설명
 -----
 N: 전체 스테이지 개수
 stages: 게임을 이용하는 사용자가 현재 멈춰있는 스테이지의 번호가 담긴 배열
 실패율:
 스테이지에 도달했으나 아직 클리어하지 못한 플레이어의 수 / 스테이지에 도달한 플레이어 수
 
 실패율이 높은 스테이지부터 내림차순으로 스테이지의 번호 배열 return
 */

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    // [0,...,N+1]
    // 스테이지를 편히 세기 위해 앞에 0을, 그리고 클리어시(N+1) 스테이지를 추가해주어서 N+2 크기 만큼의 배열을 만들어준다.
    var counts: [Int] = [Int](repeating: 0, count: N + 2)
    
    // 주어진 stage를 돌면서 해당 스테이지를 인덱스로 가진 count에 1씩 늘려준다.
    // 그럼 counts배열의 값들은 해당 스테이즈(인덱스)를 수행중인 유저들의 수.
    // 그리고 해당 스테이지 뒤에 있는 값들은 모두 해당 스테이지를 클리어한 유저들이 된다.
    for stage in stages {
        counts[stage] += 1
    }
    
    var results: [(Double, Int)] = []
    for (idx, count) in counts.enumerated() {
        let yetClear = count // 아직 해당 스테이지를 깨지 못한 유저
        var total = count // 스테이지에 도달한 유저. 현재 진행중인 유저도 포함돼기 때문에 진행중인 유저를 초기값으로 가진다.
        
        for j in idx+1..<counts.count {
            total += counts[j] // 뒤에 있는 유저들은 모두 해당 스테이지에 도달한 유저이기 때문에 더해준다.
        }
        
        let rate = Double(yetClear) / Double(total) // 실패율 구하기
        results.append((rate, idx)) // (실패율, 스테이지 번호) 형태로 results배열에 담기
    }
    
    results.sort { a, b in
        if a.0 == b.0 { // 실패율 같은 경우에는
            return a.1 < b.1 // 스테이지 번호가 작은순대로
        }
        return a.0 > b.0 // 기본은 실패율 내림차순으로 정렬
    }
    
    // 조건에 맞게 정렬이 모두 끝난 (실패율, 스테이지)배열에서 N+1(클리어 스테이지)와 0(인덱싱을 편하게 하기 위해 추가한 스테이지) 둘은 필요가 없으니 그 둘을 제외한 배열을 새로 만들어주었다.
    var answer = results.filter { a in
        return a.1 != N+1 && a.1 != 0
    }.map { a in
        return a.1
    }
    return answer // 새로 만든 배열을 return
}

//solution(5, [2, 1, 2, 6, 2, 4, 3, 3]    )
//solution(4, [4,4,4,4,4]    )
