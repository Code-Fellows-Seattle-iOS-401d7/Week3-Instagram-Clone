
import UIKit


                        ////// CLASS 15 \\\\\\
                        ////// 10/28/16 \\\\\\



/*
 #NOTES:
 
 
 *** Queues ***
 
 --> data structure in which entities in the collection are kept in order and the principla operations on the collection are addition
 
 * line at the grocery store
    - enqueue into the back of the line
    - dequeue from the front of the line(after groceries bought)
 
 -- FIFO First-In First-Out
 
 - used for managing requests so they can address them by time requested
 - CPU's use queues to properyl schdeule operations
 
 -- implementng a queue
    - can be different based on what data structure you are using
    - can be implemented using an array or linked list
    - just need to implement dequeue(removing) and enqueue(adding)
    - queues can have a peek operation as well(sometimes called front), simply returns the front most entity
 
 
 *** Stacks ***
 
 --> "one of the most important data structures in computer science"
 
 - navigation controllers are stacks
 - push, pop, peek operations
 EX: deck of playing cards face down
 - can easily access the card on top
 - 2 things to do to access card on top
    -- peek
    -- pop off the deck
 
 - can use arrays or linked list
 
 
 
 
 */


class Queue {
    
    private var objects = [Any]()
    
    func enqueue(object: Any) {
        objects.append(object)
    }
    
    func dequeue() -> Any? {
        return objects.removeFirst()
    }
    
    func peek() -> Any {
        return objects[0]
    }
    
    func unenqueue(object: Any) {
        objects.removeLast()
    }
    
    func undequeue() -> Any? {
        return objects.insert(Any.self, at: 0)
    }
}


class Stack {
    
    private var objects = [Any]()
    
    func push(object: Any) {
        objects.append(object)
    }
    
    func pop() -> Any? {
        //objects.popLast()
        if !objects.isEmpty {
            return objects.removeLast()
        }
        return nil
    }
    
    func peek() -> Any {
        return objects.last!
    }
}
let myStack = Stack()
myStack.push(object: 0)
myStack.push(object: 1)
myStack.push(object: 2)
myStack.push(object: 3)
myStack.push(object: 4)

myStack.peek()

myStack.pop()
myStack.pop()
myStack.pop()
myStack.pop()
myStack.pop()
myStack.pop()

//myStack.peek()


/*
 #NOTES:
 
 
 *** Linked List ***
 
 --> linear collection of data elements, called nodes, pointing to the next node by means of a pointer
 
 - very common in interview process
 - front-most node is called the "head"
 - every node has 2 things:
    -> own data
    -> pointer to its next node
 - final node has a pointer to nil
 - "traverse"
    -- travel through every node in the linked list
 - must keep reference to the head(would lose reference to the whole list)
    ---> "var current = head"
    ---> "if current.next != nil { current = current.next }
 - must look through each node to find data
 - singly vs doubly
    -- ususally talking about singly linked list
 - operation at the front are quick, and operations at the back are slow
 - "linear time(O(N))" is more expensive than "constant time(O(1))"

 -> traversing...
    -- recursion(calling a method within method definition of itself)
    -- iteration(loop)
 
 - caveats...
    -- when performing operations on a linked list, always update the relevant next and/or previous pointers and possibly the head and tail pointers. 
 
 ** Time Complexity **
 
 - insertAtEnd(node:) --> O(N)
 - insertAtHead(node:) --> O(1)
 - insert(node: atIndex:) --> O(N)
 - count()->Int --> O(N)
 - removeAll() --> O(1)
 
 */

// creating the Node and Linked List types

// create node
class Node<T> {
    
    let data: T
    var next: Node?
    
    init(data: T) {
        self.data = data
    }
}

//create list

class LinkedList<T> {
    
    private var head: Node<T>? // for checking if linked list is empty
    
    // show insertion
    func insert(data: T) {
        let newNode = Node(data: data)
        
        if head == nil {
            head = newNode
            return
        }
        
        var current = self.head
        
        while current != nil {
            current = current?.next
        }
        
        current?.next = newNode
    }
    
    // show description
    func description() -> String {
        var description = "Head->"
        
        var current = self.head
        
        while current?.next != nil {
            description += "[\(current?.data)]-"
            current = current?.next
        }
        description += "||"
        
        return description
    }
    
    // show node(atIndex) -> Node
    func nodeAt(index: Int) -> Node<T>? {
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
    
    func insertAtHead(data: T) {
        
        let newNode = Node(data: data)
        
        newNode.next = self.head
        self.head = newNode
    }
    
    // insert at
    func insertAt(data: T, at index: Int) {
        
        if index == 0 {
            insertAtHead(data: data)
            return
        }
        
        let newNode = Node(data: data)
        
        var current = self.head
        //var next = current?.next
        var previous = current
        var counter = 0
        
        while current != nil {
            if counter == index {
                newNode.next = current
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

myList.description

let node = myList.nodeAt(index: 0)
node?.data

myList.insert(data: 5, at: 0)
myList.description





//



