//
//  Heap.swift
//  Minjae
//
//  Created by 김민재 on 2023/02/03.
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
