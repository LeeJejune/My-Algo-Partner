//
//  괄호 변환.swift
//  Minjae
//
//  Created by 김민재 on 2023/01/25.
//

import Foundation

func divideUV(p: String) -> (String, String) {
    var leftCount = 0
    var rightCount = 0
    
    var u = ""
    
    var tmp = ""
    for ch in p {
        let ch = String(ch)
        if ch == "(" {
            leftCount += 1
        } else if ch == ")" {
            rightCount += 1
        }
        tmp += ch
        if leftCount == rightCount {
            u = tmp
            break
        }
    } // 문자열 u 만들기
    
    let index = p.index(p.startIndex, offsetBy: u.count)
    let v = String(p[index...]) // 문자열 v 만들기
    
    return (u, v)
}

func checkRightString(str: String) -> Bool {
    var st: [String] = []
    for ch in str {
        let ch = String(ch)
        if ch == "(" {
            st.append(ch)
        } else if ch == ")" {
            if let last = st.last {
                if last == "(" {
                    st.popLast()
                }
            }
        }
    }
    
    var isRight = false // u가 올바른 괄호 문자열인지 확인하기
    if st.isEmpty {
        isRight = true
    }
    return isRight
}

func solution(_ p:String) -> String {
    var tmp = ""
    if p == "" {
        return ""
    }
    
    let div = divideUV(p: p)
    var u = div.0
    var v = div.1
    
    if checkRightString(str: u) {
        tmp = u + solution(v)
    } else {
        tmp += "("
        tmp += solution(v)
        tmp += ")"
        
        u.removeFirst()
        u.removeLast()
        var uArr = Array(u)
        for i in 0..<uArr.count {
            if uArr[i] == "(" {
                uArr[i] = ")"
            } else {
                uArr[i] = "("
            }
        }
        tmp += String(uArr)
    }
    
    return tmp
}


//print(solution(")("    ))
print(solution("()))((()"    ))
