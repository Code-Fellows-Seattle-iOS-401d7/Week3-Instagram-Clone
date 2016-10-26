//: Write a function that returns all the odd elements of an array.

let array = ["a", "b", "c", "d", "e", "f", "g"]

func odds<T>(_ array: [T]) -> [T] {
    return array.enumerated()
                .filter({ $0.0 % 2 != 0 })
                .map({ $0.1 })
}

odds(array) == ["b", "d", "f"]


//extension Array {
//    static func odds<T>()->[T]{
//        return self.enumerated()
//                   .filter({ $0.0 % 2 != 0 })
//                   .map({ $0.1 })
//    }
//}
