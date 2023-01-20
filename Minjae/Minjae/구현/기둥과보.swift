import Foundation

func possible(answer: Set<[Int]>) -> Bool {
    /*
     건축이 올바른지 아닌지 확인하는 함수이다.
     answer: 기둥과 보를 한번씩 설치하고 삭제해보며 바뀌는 set
     return값: 올바른 건축인지 아닌지에 대한 boolean 값
     
     O(n)
     */
    for ans in answer {
        let x = ans[0]
        let y = ans[1]
        let type = ans[2] // 0은 기둥, 1은 보
        
        if type == 0 { // 기둥이라면??
            
            if y == 0 || // 바닥이거나
                (answer.contains([x - 1, y, 1]) || answer.contains([x, y, 1])) || // 보의 한쪽 끝에 있거나
                answer.contains([x, y - 1, 0]) { // 다른 기둥 위에 있으면
                continue // 가능하므로 continue
            }
            return false // 위의 조건에 해당이 안된다면 불가능한 건축이므로 return false
            
        } else { // 보라면??
            
            if y != 0 && // 보는 바닥에 놓을 수 없고
                answer.contains([x, y - 1, 0]) || answer.contains([x + 1, y - 1, 0]) || // 한쪽 끝 부분이 기둥 위에 있거나
                (answer.contains([x - 1, y, 1]) && answer.contains([x + 1, y, 1])) { // 양쪽 끝 부분이 다른 보와 모두 연결돼있으면
                continue // 가능한 건축이므로 continue
            }
            return false // 위의 조건에 해당이 안된다면 불가능한 건축이므로 return false
            
        }
    }
    
    return true // 위에서 false로 리턴이 되지않았다면 해당 건축은 조건에 부합하다는 것이므로 return true
}

func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] { // O(n^2)
    
    var answer = Set<[Int]>() // set으로 answer배열을 만들어주었다. Array가 아닌 set으로 한 이유는 contain을 통해서 해당값이 포함돼있는지 확인하기 위함인데, Array일 경우 contain메소드를 사용하는데 걸리는 시간복잡도가 O(n)이다. 하지만 set은 hashable이기 때문에 O(1)로 바로 해당값이 있는지 알 수 있다. 만약 Array로 한다면 로직의 O(n^3)의 엣지케이스에 걸려서 시간초과가 나게된다.
    
    for frame in build_frame {
        let x = frame[0] // x 좌표 (가로)
        let y = frame[1] // y 좌표 (세로)
        let a = frame[2] // 0은 기둥, 1은 보
        let b = frame[3] // 0은 삭제, 1은 설치
        
        if b == 0 { // 삭제하는 경우
            let index = answer.firstIndex(of: [x, y, a])!
            answer.remove(at: index) // 삭제를 했다가
            if !possible(answer: answer) { // 불가능하다면??
                answer.insert([x, y, a]) // 다시 넣어주기 (roll back)
            }
            
        } else { // 설치하는 경우
            answer.insert([x, y, a]) // 설치했다가
            if !possible(answer: answer) { // 불가능하다면?
                let index = answer.firstIndex(of: [x, y, a])!
                answer.remove(at: index) // 다시 삭제하기 (roll back)
            }
        }
    }
    
    var tmp = Array(answer) // set -> Array
    tmp.sort { a, b in // 정답조건에 맞게 배열을 sorting해준다.
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



//_ = solution(5, [[1,0,0,1],[1,1,1,1],[2,1,0,1],[2,2,1,1],[5,0,0,1],[5,1,0,1],[4,2,1,1],[3,2,1,1]])
_ = solution(5,     [[0,0,0,1],[2,0,0,1],[4,0,0,1],[0,1,1,1],[1,1,1,1],[2,1,1,1],[3,1,1,1],[2,0,0,0],[1,1,1,0],[2,2,0,1]])
