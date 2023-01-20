import Foundation

func rotateMatrix(_ matrix: [[Int]]) -> [[Int]] { // 행렬을 90도 회전하는 함수이다.
    /*
     1행 -> 3열
     2행 -> 2열
     3행 -> 1열
     */
    var tmp: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: matrix.count), count: matrix.count)
    
    for j in stride(from: matrix.count-1, through: 0, by: -1) {
        for i in 0..<matrix.count {
            tmp[i][j] = matrix[matrix.count - j - 1][i]
        }
    }
    
    return tmp
}

func checkUnlock(_ matrix: [[Int]]) -> Bool { // 행렬의 홈이 열쇠와 겹치는 부분없이 모두 채워졌는지 확인하는 함수이다.
    let n = matrix.count / 3 // 행렬을 3배로 확장시켰기 때문에 / 3 을 통해 필요한 행렬의 부분의 길이를 가져와서 저장한 변수이다.
    
    for i in n..<n*2 { // 확장된 행렬(n * 3)에서 lock은 가운데에 있기 때문에, 그 범위는 n..<n*2가 된다.
        for j in n..<n*2 {
            if matrix[i][j] != 1 { // 행렬의 가운데 부분을 전체순회하면서 1이 아닌 값(2 or 0)이 나온다면 겹치는 부분 혹은 홈이 채워지지 않은 부분이 있는 것이므로 바로 return false
                return false
            }
        }
    }
    return true // 위의 과정 중에서 return false가 되지 않았다면 조건에 부합한 것이므로 return true
}

func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    
    let n = key.count // 열쇠행렬의 길이 N * N
    let m = lock.count // 자물쇠행렬의 길이 M * M
    
    // 아래는 3배 크기로 행렬을 확장하고 가운데 부분에 lock을 넣어주는 과정이다.
    var newLock = [[Int]](repeating: [Int](repeating: 0, count: m * 3), count: m * 3) // 기존 lock의 3배 크기의 확장된 행렬을 만들어서 newLock에 저장한다.
    for i in 0..<m { // 자물쇠 행렬의 길이 m만큼 순회하면서
        for j in 0..<m {
            newLock[i + m][j + m] = lock[i][j] // 거기에 m을 더한값만큼을 위치로 가지고 기존의 lock을 넣어준다.
        }
    }
    
    
    
    var rkey = key // rkey는 처음 key를 가지고 있다. 해당 변수를 rotate시켜주면서 완전탐색을 통해 자물쇠를 푸는지 여부를 검사할 것이다.
    for _ in 0..<4 { // 4번 rotate할 예정.
        
        rkey = rotateMatrix(rkey) // for문의 처음 부분에서 rotate를 먼저해주고 검사를 시작한다.
        
        for y in 0..<m * 2 { // 확장된 행렬의 가운데 부분까지 모두 순회하며
            for x in 0..<m * 2 { //
                
                for i in 0..<n { // n(열쇠의 크기)만큼 열쇠 부분을 newLock에 더해준다. 겹치는 부분은 2가 될 것이고 0이였던 부분에서 key가 겹치면 1이 될 것이다.
                    for j in 0..<n {
                        newLock[y + i][x + j] += rkey[i][j]
                    }
                }

                if checkUnlock(newLock) { // 겹치는 부분을 포함해서 모두 연산을 마친 후, newLock이 풀렸는지 검사하고
                    return true // 풀렸다면 return true
                }
                
                // 위에서 return true가 되지 않았다는 것은 자물쇠가 풀리지 않은 것이므로 다음 단계를 위해서 방금 넣었던 key를 다시 빼줘야한다.
                for i in 0..<n {
                    for j in 0..<n {
                        newLock[y + i][x + j] -= rkey[i][j] // 위의 과정과 똑같지만, 이번에는 빼준다.
                    }
                }
            }
        }
        
    }
    
    return false // 4번 rotate하면서 true로 return되지 않았다면 해당 key로는 자물쇠를 풀 수 없는 것이므로 return false
}


let a = solution(
    [[0, 0, 0], [1, 0, 0], [0, 1, 1]],
    [[1, 1, 1], [1, 1, 0], [1, 0, 1]]
)
print(a)


func drawMatrix(_ matrix: [[Int]]) {
    for i in 0..<matrix.count {
        for j in 0..<matrix.count {
            print(matrix[i][j],terminator: " ")
        }
        print()
    }
}
