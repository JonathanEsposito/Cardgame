//
//  CardFontTranslation.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

let setOfCharacters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a"]

/// array[Shape][Shading][Number]
let characterArray = [
    [["A","B","C"],["J","K","L"],["S","T","U"]],
    [["D","E","F"],["M","N","O"],["V","W","X"]],
    [["G","H","I"],["P","Q","R"],["Y","Z","a"]]
]

let stringToCardPropertiesTranslation: [String : (shape:Shape,shading:Shading,number:Number)] = [
    "A" : (shape:.diamond,shading:.outlined,number:.one),
    "B" : (shape:.diamond,shading:.outlined,number:.two),
    "C" : (shape:.diamond,shading:.outlined,number:.three),
    "D" : (shape:.oval,shading:.outlined,number:.one),
    "E" : (shape:.oval,shading:.outlined,number:.two),
    "F" : (shape:.oval,shading:.outlined,number:.three),
    "G" : (shape:.squiggle,shading:.outlined,number:.one),
    "H" : (shape:.squiggle,shading:.outlined,number:.two),
    "I" : (shape:.squiggle,shading:.outlined,number:.three),
    "J" : (shape:.diamond,shading:.striped,number:.one),
    "K" : (shape:.diamond,shading:.striped,number:.two),
    "L" : (shape:.diamond,shading:.striped,number:.three),
    "M" : (shape:.oval,shading:.striped,number:.one),
    "N" : (shape:.oval,shading:.striped,number:.two),
    "O" : (shape:.oval,shading:.striped,number:.three),
    "P" : (shape:.squiggle,shading:.striped,number:.one),
    "Q" : (shape:.squiggle,shading:.striped,number:.two),
    "R" : (shape:.squiggle,shading:.striped,number:.three),
    "S" : (shape:.diamond,shading:.solid,number:.one),
    "T" : (shape:.diamond,shading:.solid,number:.two),
    "U" : (shape:.diamond,shading:.solid,number:.three),
    "V" : (shape:.oval,shading:.solid,number:.one),
    "W" : (shape:.oval,shading:.solid,number:.two),
    "X" : (shape:.oval,shading:.solid,number:.three),
    "Y" : (shape:.squiggle,shading:.solid,number:.one),
    "Z" : (shape:.squiggle,shading:.solid,number:.two),
    "a" : (shape:.squiggle,shading:.solid,number:.three)
]
