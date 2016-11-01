

// write a function that determines how many words are in a sentence.

import UIKit

var str = "How many words are in this sentence?"

func numberOfWordsInSentence(string: String) -> Int {
    
    var words = 1
    
    if string.characters.contains(" ") {
        for i in string.characters {
            if i == " " {
                words += 1
            }
        }
        return words
    } else {
        return words
    }
}
numberOfWordsInSentence(string: str)
numberOfWordsInSentence(string: "Hello")
numberOfWordsInSentence(string: "Hello there")
numberOfWordsInSentence(string: "Hey we're going to make a really long sentence so we can test the function and never have to count out how many words are in a sentence again!")