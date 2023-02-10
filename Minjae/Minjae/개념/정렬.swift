//
//  main.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/05.
//

import Foundation

/*
 선택 정렬(selection sort)은 가장 작은 데이터부터 골라서 왼쪽으로 배치하기
 삽입 정렬(insertion sort)은 왼쪽은 정렬된 데이터라고 가정하고, 적절한 위치에 데이터 삽입하기
 */

var arr = [7, 5, 9, 0, 3, 1, 6, 2, 4, 8]

func selectionSort(array: [Int]) {
    var array = array
    for i in 0..<array.count {
        var minIndex = i
        for j in i+1..<array.count {
            if array[minIndex] > array[j] {
                minIndex = j
            }
        }
        array.swapAt(minIndex, i)
    }
    print(array)
}

func insertionSort(array: [Int]) {
    var array = array
    
    for i in 1..<array.count {
        for j in stride(from: i, to: 0, by: -1) {
            if array[j] < array[j-1] {
                array.swapAt(j, j-1)
            } else {
                break
            }
        }
    }
    
    print(array)
}

// hoare 파티션
func quickSort(array: inout [Int], start: Int, end: Int) {
    if start >= end {
        return
    }
    
    var pivot = start
    var left = start + 1
    var right = end
    
    while left <= right {
        // 피벗보다 큰 수 찾기
        while left <= end && array[left] <= array[pivot] {
            left += 1
        }
        
        // 피벗보다 작은 수 찾기
        while right > start && array[right] > array[pivot] {
            right -= 1
        }
        
        // 엇갈렸다면 피벗과 작은 데이터를 교체
        if left > right {
            array.swapAt(pivot, right)
        } else { // 안엇갈리면 작은<->큰 데이터 교체
            array.swapAt(left, right)
        }
    }
    // 분할 이후에 왼쪽 부분과 오른쪽 부분에서 각각 정렬 수행
    quickSort(array: &array, start: start, end: right - 1)
    quickSort(array: &array, start: right + 1, end: end)
}

// 계수 정렬
func countingSort(array: [Int]) {
    var count = [Int](repeating: 0, count: array.count)
    
    for num in array {
        count[num] += 1
    }
    
    for (idx, cnt) in count.enumerated() {
        for _ in 0..<cnt {
            print(idx, terminator: " ")
        }
    }
    print()
}

//quickSort(array: &arr, start: 0, end: arr.count - 1)
//print(arr)
//selectionSort(array: arr)
//insertionSort(array: arr)
//arr = [7, 5, 9, 0, 3, 1, 6, 2, 9, 1, 4, 8, 0, 5, 2]
//countingSort(array: arr)
