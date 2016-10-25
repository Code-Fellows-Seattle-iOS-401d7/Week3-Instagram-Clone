
import UIKit


/*
 
 Write a function that returns all the odd elements in an array
 
 */


let arr: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]


func oddNumbers(arr: [Int]) -> [Int] {
    var oddArray: [Int] = []
    
    for n in arr {
        if n % 2 == 0 {
            continue
        } else if n % 2 != 0 {
            oddArray.append(n)
        }
    }
    return oddArray
}
oddNumbers(arr: arr)
