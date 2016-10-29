//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Linked Lists"


class Node<T>{
    
    let data: T
    var next: Node?
    
    init(data: T){
        self.data = data
    }
}

class LinkedList<T>{
    
    private var head : Node<T>?
    
    func insert(data: T){
        let newNode = Node(data: data)
        
        if head == nil {
            head = newNode
            return
        }
        
        var current = self.head
        
        while current?.next != nil {
            current = current?.next
        }
        current?.next = newNode
    }
    
    var description : String{
        var description = "Head->"
        
        var current = self.head
        
        while current != nil {
            description += "[\(current!.data)]-"
            current = current?.next
        }
        
        description += "||"
        
        return description
    }
    
    func nodeAt(index: Int) -> Node<T>?{
        var current = self.head
        var currentIndex = 0
        
        while current != nil {
            if currentIndex == index {
                return current
            }
            
            current = current?.next
            currentIndex += 1
        }
        
        return nil
    }
    
    
    func insertAtHead(data: T){
        let newNode = Node(data: data)
        
        newNode.next = self.head
        self.head = newNode
        
    }
    
    func insert(data: T, at index: Int){
        
        if index == 0{
            insertAtHead(data: data)
            return
        }
        
        let newNode = Node(data: data)
        
        var current = self.head
        var previous = current
        
        var counter = 0
        
        while current != nil{
            if counter == index{
                newNode.next = current!
                previous?.next = newNode
                return
            }
            previous = current
            current = current?.next
            counter += 1
        }
        
    }
}

let myList = LinkedList<Int>()
myList.insert(data: 100)
myList.insert(data: 200)
myList.insert(data: 300)
myList.insert(data: 123)
myList.insert(data: 10000)
myList.insert(data: 100)

myList.description

let node = myList.nodeAt(index: 5)
node?.data



myList.insert(data: 5, at: 0)
myList.description











