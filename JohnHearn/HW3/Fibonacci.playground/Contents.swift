/*
 The first 100 Fibonacci numbers:
 
 Generating the first 93 Fibonacci numbers is easy, but you overflow on the 94th.
 To get F_n for n > 93, without having to implement UInt128, we cheat by manually 
 adding two strings (padded with 0 to the length of the longest Fibonacci we want 
 to compute) digit by digit. It's not very effecient, but it works.
 
 The function prints out all the Fibonaccis as they are created, but also returns
 as array of F_0 through F_300 as strings.
*/


let the94thFib  = "19740274219868223167",
    the95thFib  = "31940434634990099905",
    the96thFib  = "51680708854858323072",
    the97thFib  = "83621143489848422977",
    the98thFib  = "135301852344706746049",
    the99thFib  = "218922995834555169026",
    the100thFib = "354224848179261915075",
    the300thFib = "222232244629420445529739893461909967206666939096499764990979600",
    the1000thFib = "43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875"


func pad(_ s: String,
         _ length: Int? = 210 ) -> String{
//         _ length: Int? = the300thFib.characters.count ) -> String{
    var t = s
    while t.characters.count < length! {
        t = "0" + t
    }
    return t
}


func fib(_ number: Int) -> [String]{
    let fibMax = number + 1
    var output = [String](repeating: "", count: fibMax)

    output[0] = pad("0")
    output[1] = pad("1")

    print("1 :", output[1])

    for ii in 2..<94 {
        output[ii] = pad(String(UInt64(output[ii-2])! + UInt64(output[ii-1])!))
        print(String(ii), ":", output[ii])
    }

    for ii in 94..<fibMax {
        var left  = Array(output[ii-2].characters.reversed().enumerated())
        var right = Array(output[ii-1].characters.reversed().enumerated())
        var s = [String](repeating: "", count: right.count )
        var sum   = 0
        var carry = 0
        var value = 0

        for (jj, _) in left {
            sum =  Int(String(left[jj].element))! + Int(String(right[jj].element))! + carry
            carry = ( sum - (sum % 10) ) / 10
            value = sum % 10
            s[jj] = String(value)

        }

        output[ii] = s.reversed().joined(separator: "")
        print(String(ii), ":", output[ii])
    }


    return output
}

let fibs = fib(1000)

fibs[94]   == pad(the94thFib)
fibs[95]   == pad(the95thFib)
fibs[96]   == pad(the96thFib)
fibs[97]   == pad(the97thFib)
fibs[98]   == pad(the98thFib)
fibs[99]   == pad(the99thFib)
fibs[100]  == pad(the100thFib)
fibs[300]  == pad(the300thFib)
fibs[1000] == pad(the1000thFib)




