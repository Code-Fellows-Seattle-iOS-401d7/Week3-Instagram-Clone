//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Stacks"


class Stack{
    
    private var objects = [Any]()
    
    
    
    func push(object: Any){
        objects.insert(object, at: 0)
    }
    
    func pop()->Any?{
        if !objects.isEmpty {
            return objects.removeFirst()
        }
        return nil
    }
    
    func peek()-> Any{
        return objects.last
    }
}


let myStack = Stack()


myStack.push(object: 0)
myStack.push(object: 1)
myStack.push(object: 2)
myStack.push(object: 3)

myStack.peek()


myStack.pop()
myStack.pop()
myStack.pop()
myStack.pop()
myStack.pop()

myStack.peek()


























