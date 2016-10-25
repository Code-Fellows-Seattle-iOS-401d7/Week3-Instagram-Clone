// Code Challenge: Write a function that determines how many words there are in a sentence.

import Foundation

var sentence = "Hello ma baby, hello ma honey, hello ma ragtime gal."

func wordCount(_ sentence: String) -> Int {
    return sentence.characters.split{ $0 == " " }.count
}

wordCount(sentence) == 10
