//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Monday: Write a function that determines how many words there are in a sentence.

func countTheWords(string : String) -> Int {
    var count = 1
    for character in string.characters {
        if character == " " {
            count += 1
        }
    }
    return count
}

countTheWords(string: "I'm Henry the 8th I am!")

// Testing with a sentence with 239 words.
countTheWords(string: "Knowing that millions of people around the world would be watching in person and on television and expecting great things from him — at least one more gold medal for America, if not another world record — during this, his fourth and surely his last appearance in the World Olympics, and realizing that his legs could no longer carry him down the runway with the same blazing speed and confidence in making a huge, eye-popping leap that they were capable of a few years ago when he set world records in the 100-meter dash and in the 400-meter relay and won a silver medal in the long jump, the renowned sprinter and track-and-field personality Carl Lewis, who had known pressure from fans and media before but never, even as a professional runner, this kind of pressure, made only a few appearances in races during the few months before the Summer Olympics in Atlanta, Georgia, partly because he was afraid of raising expectations even higher and he did not want to be distracted by interviews and adoring fans who would follow him into stores and restaurants demanding autographs and photo-opportunities, but mostly because he wanted to conserve his energies and concentrate, like a martial arts expert, on the job at hand: winning his favorite competition, the long jump, and bringing home another Gold Medal for the United States, the most fitting conclusion to his brilliant career in track and field.")


// Tuesday: Write a function that returns all the odd elements of an array.

let array = ["odd", "even", "odd", "even", "odd", "even", "odd"]

let numbersArray = [1,2,3,4,5,6,7]

func getTheOddElements(array: [Any]) -> [Any] {
    
    var newArray = [Any]()
    for (index, value) in array.enumerated() {
        if index % 2 == 0 {
            newArray.append(value)
        }
    }
    return newArray
}

getTheOddElements(array: array)
getTheOddElements(array: numbersArray)

// Wednesday: Write a function that computes the list of the first 100 Fibonacci numbers.(This is trickier than it seems).

// Fibonacci formula: f(n) = f(n-1) + f(n-2)

let starter = [1, 1]

func calculateFibonaccis(numberOfFibs: Int) -> [Int] {
    let count = (numberOfFibs - 2)
    var numbers = [1, 1]
    var nextNumber = 0
    for _ in 1...count {
        if numbers.last == 1 {
            nextNumber = numbers.last! + 1
            numbers.append(nextNumber)
        } else {
            var fib1 = numbers[numbers.count - 1]
            var fib2 = numbers[numbers.count - 2]
            nextNumber = fib1 + fib2
            numbers.append(nextNumber)
        }
    }
    return numbers
}

calculateFibonaccis(numberOfFibs: 100)






