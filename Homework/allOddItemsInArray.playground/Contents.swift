
import UIKit


/*
 
 Write a function that returns all the odd elements in an array
 
 */


// for INTS:

let arr: [Int] = [34, 345, 334, 4, 34, 55, 22, 66]


func oddNumbers(arr: [Int]) -> [Int] {
    var oddArray: [Int] = []
    
    for n in stride(from: arr.startIndex + 1, to: arr.count, by: 2) {
        oddArray.append(arr[n])
    }
    return oddArray
}
oddNumbers(arr: arr)


// for STRINGS:

let stringArray = ["HELLO", "HEY", "BUS", "HACKER", "JAKE", "DOBSON", "CODE", "FELLOWS"]

func oddElements(arrayOfStrings: [String]) -> [String] {
    var oddsArray = [String]()

    for element in stride(from: arrayOfStrings.startIndex + 1, to: arrayOfStrings.count, by: 2) {
        //print(stringArray[element])
        oddsArray.append(arrayOfStrings[element])
    }
    return oddsArray
}
oddElements(arrayOfStrings: stringArray)





