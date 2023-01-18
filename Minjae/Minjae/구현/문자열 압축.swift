//
//  문자열 압축.swift
//  algo
//
//  Created by 김민재 on 2022/12/22.
//

import Foundation

func solution(_ s:String) -> Int {
    
    let s = Array(s) // string을 인덱스로 편하게 관리해주기 위해서 Array로 바꿔주었다.
    var answer = s.count // 정답값을 저장하기 위해 초기값은 입력받는 s의 길이로 해주었다.
    
    for step in 1..<(s.count / 2 + 1) { // step은 문자열을 자르는 개수 단위를 뜻한다. 1부터 s.count / 2까지 개수를 늘려가며 문자열을 잘라나간다.
        var tmp = "" // 압축되는 문자열을 저장하기 위한 변수이다.
        var comp = String(s[..<step]) // 비교를 위한 기준이 되는 변수이다. 앞에서부터 step 크기만큼의 문자열을 가진다.
        
        var count = 1 // count는 연속적으로 같은 문자열이 얼마나 나오는지 세기 위한 변수이다. 처음에 자기 자신이 포함돼있기 때문에 1로 시작한다.
        for j in stride(from: step, to: s.count, by: step) { // j는 처음 step만큼의 문자열을 제외하고 그 다음 step부터 시작한다. step부터 문자열의 마지막까지 step(기준이 되는 comp의 길이)만큼 인덱스를 건너뛴다.
            
            let endIndex = j + step > s.count ? s.count : j + step // j의 다음 step이 문자열의 개수를 넘어가버린다면 index out of range가 되기 때문에 그럴 경우에는 문자열의 개수로 초기화시켜준다.
            
            if comp == String(s[j..<endIndex]) { // comp와 다음 step의 문자열(s[j..<j+step])이 같다면??
                count += 1 // count를 1 늘려준다.
            } else { // 만약 comp와 다음 step의 문자열이 같지 않다면??
                // 해당 comp를 기준으로 하는 비교는 끝난 것이기 때문에 '(숫자)comp'형태로 tmp에 넣어주면 될 것이다.
                if count >= 2 { // count가 1일 경우에는 문제에서 무시하기 때문에, 2이상일때는
                    tmp += String(count) // tmp에 추가해준다
                }
                tmp += comp // comp는 항상 추가해야한다
                
                comp = String(s[j..<endIndex]) // comp는 이전값과 달랐던 다음 step의 문자열로 업데이트한다.
                count = 1 // count 변수도 다시 1로 초기화해준다.
            }
        }
        
        if count >= 2 {
            /*
             inner-for문을 끝내고 나오면 마지막에 남는 문자열이 생긴다. 예를 들어 예제 1의 경우, "aabbaccc"에서 마지막 ccc는 count개수만 증가하고 else쪽으로 빠지지않아
             문자열에 추가가 안된채로 끝나게 된다. 이러한 경우를 위해 count가 2이상일 경우를 한번 더 검사하고, 그 이상이라면??
             */
            tmp += String(count) // count를 tmp에 추가해준다.
        }
        tmp += comp // 공통으로 항상 들어가야하는 comp부분을 추가해준다.
        
        answer = min(answer, tmp.count) // 정답은 기존에 있는 정답값(이전 step만큼 문자열을 잘라서 압축했을 때의 문자열의 길이)와 생성된 새로운 tmp 길이를 비교해서
        // 가장 작은 값을 정답값으로 가진다.
    }
    
    return answer
}

/*
 1 try
 2 try
 */
