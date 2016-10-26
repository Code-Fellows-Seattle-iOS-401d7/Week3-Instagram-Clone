//: Playground - noun: a place where people can play

func fibonacci(_ input: UInt8) -> [UInt64]{
    let number = Int(input) + 1
    var output = [UInt64](repeating: 0, count: number)

    output[0] = 0
    output[1] = 1

    for index in 2..<number {
        output[index] = output[index-1] + output[index-2]
    }

    return output
}

let fib = fibonacci(93)



let stringified = fib.dropFirst().reduce("", { $0 + String($1) + "\n" })


print(stringified)