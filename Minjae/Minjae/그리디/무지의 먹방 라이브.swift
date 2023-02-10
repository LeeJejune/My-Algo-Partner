//
//  무지의 먹방 라이브.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/02.
//

import Foundation

struct Heap<T> {
    var elements: [T]
    let priorityFunction: (T, T) -> Bool
    
    init(elements: [T] = [], priorityFunction: @escaping (T, T) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        buildHeap() // heapify하기
    }
    
    mutating func buildHeap() {
        for index in (0..<count/2).reversed() {
            siftDown(elementAtIndex: index)
        }
    }
    
    // priority queue functions
    var isEmpty : Bool {
      return elements.isEmpty
    }

    var count : Int {
      return elements.count
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    mutating func enqueue(_ element: T) {
        elements.append(element) // 마지막에 요소 삽입
        siftUp(elementAtIndex: count - 1) // sift-up
    }
    
    mutating func dequeue() -> T? {
        guard !isEmpty else { return nil }
        
        swapElement(at: 0, with: count - 1)
        
        let element = elements.removeLast()
        if !isEmpty {
            siftDown(elementAtIndex: 0)
        }
        
        return element
    }
    
    // helper functions
    func isRoot(_ index: Int) -> Bool {
        return index == 0
    }
    
    func leftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    func rightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return priorityFunction(elements[firstIndex], elements[secondIndex])
    }
    
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count && isHigherPriority(at: childIndex, than: parentIndex)
        else {
            return parentIndex
        }
        
        return childIndex
    }
    
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else { return }
        elements.swapAt(firstIndex, secondIndex)
    }
    
    mutating func siftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index)
        
        guard !isRoot(index),
              isHigherPriority(at: index, than: parent)
        else { return }
        swapElement(at: index, with: parent)
        siftUp(elementAtIndex: parent)
    }
    
    mutating func siftDown(elementAtIndex index: Int ) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex {
            return
        }
        
        swapElement(at: index, with: childIndex)
        siftDown(elementAtIndex: childIndex)
    }
}




func solution(_ food_times:[Int], _ k:Int64) -> Int {
    
    if food_times.reduce(0, +) <= k { // 음식 다 먹는시간보다 K가 같거나 크다면 다 먹은것이므로 -1
        return -1
    }
    
    var foodTimes: [(Int, Int)] = [] // (시간, 음식 번호) 형태로 우선순위 큐에 삽입
    for (idx, time) in food_times.enumerated() {
        foodTimes.append((time, idx+1))
    }
    
    var heap = Heap(elements: foodTimes) { a, b in
        return a.0 < b.0 // 시간 오름차순으로 정렬
    }
    
    var sumVal = 0 // 먹기 위해 사용한 시간
    var previous = 0 // 직전에 다 먹은 음식 시간
    var length = foodTimes.count // 현재 남은 음식 개수
    
    // sumVal + (현재 음식 시간 - 직전 음식 시간) * 현재 음식 개수 와 K 비교
    // k보다 크다면?? K안에 다먹을 수 없는 것
    while sumVal + ((heap.peek()?.0 ?? 0) - previous) * length <= k {
        var now = heap.dequeue()?.0 // 음식 시간
        
        // 음식을 다 먹으려면 음식 시간 * 현재 남은 음식 개수
        // 앞에 음식 다 먹으면서 같이 먹었으니까 (현재 음식 시간-이전 음식시간)은 즉, 남은 음식
        // 높이가 되고, 남은 개수는 너비가 된다
        // sumVal += h x w
        sumVal += ((now ?? 0) - previous) * length
        
        length -= 1 // 다먹었으니까 음식 개수 - 1
        previous = now ?? 0 // 이전에 먹은 음식시간은 초기화
    }
    
    // 남은 음식들 번호순으로 정렬하기
    var result = heap.elements.sorted { a, b in
        return a.1 < b.1
    }
    
    // 순서를 찾기 위해서 k - sumVal을 뺀 것을 남은 개수로 % 연산 해주면 몇번째 음식을 먹어야하는지 알 수 있다
    return result[(Int(k) - sumVal) % length].1
}

print(
    solution([3, 1, 2], 5)
)
