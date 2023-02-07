//
//  최대힙.swift
//  Minjae
//  백준 11279
//  Created by 김민재 on 2023/02/06.
//

import Foundation

struct Heap<T> {
    var elements: [T]
    var priorityFunction: (T, T) -> Bool
    
    init(elements: [T] = [], priorityFunction: @escaping (T, T) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        buildHeap()
    }
    
    mutating func buildHeap() {
        for i in (0..<count/2).reversed() {
            siftDown(startIndex: i)
        }
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
        siftUp(startIndex: count - 1)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        swapElement(at: 0, with: count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            siftDown(startIndex: 0)
        }
        return element
    }
    
    //
    func isRoot(_ index: Int) -> Bool {
        return index == 0
    }
    
    func leftChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }
    
    func rightChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
    
    func parentIndex(_ index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriorityIndex(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return priorityFunction(elements[firstIndex], elements[secondIndex])
    }
    
    func highestPriorityIndex(at parentIndex: Int, than childIndex: Int) -> Int {
        guard childIndex < count && isHigherPriorityIndex(at: childIndex, than: parentIndex)
        else {
            return parentIndex
        }
        return childIndex
    }
    
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(
            at: highestPriorityIndex(at: parent, than: leftChildIndex(parent)),
            than: rightChildIndex(parent)
        )
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else { return }
        elements.swapAt(firstIndex, secondIndex)
    }
    
    mutating func siftUp(startIndex: Int) {
        let parent = parentIndex(startIndex)
        
        guard !isRoot(startIndex),
              isHigherPriorityIndex(at: startIndex, than: parent)
        else {
            return
        }
        elements.swapAt(parent, startIndex)
        siftUp(startIndex: parent)
    }
    
    mutating func siftDown(startIndex: Int) {
        let childIndex = highestPriorityIndex(for: startIndex)
        if childIndex == startIndex {
            return
        }
        elements.swapAt(childIndex, startIndex)
        siftDown(startIndex: childIndex)
    }
}

let N = Int(readLine()!)!
var ops: [Int] = []
for _ in 0..<N {
    ops.append(Int(readLine()!)!)
}

var heap = Heap<Int>(priorityFunction: <)
for op in ops {
    if op == 0 {
        if let element = heap.dequeue() {
            print(element)
        } else {
            print(0)
        }
    } else {
        heap.enqueue(op)
    }
}
