//
//  CardsDeckFactory.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

class setCardDeckFactory: CardDeckFactory {
    class func generateCardDeck(withDifficulty difficulty: Difficulty) -> CardDeck {
        var arrayOfCards: [Card] = []
        
        switch difficulty {
        case .easy:
            // Keep one random property static
            arrayOfCards = []
            let staticPropertie = SetCardProperties.randomProperties(1)
            staticPropertie.forEach {
                switch $0 {
                case .color:
                    let staticColor = Array(hexColor.values).shuffled.choose(1).first
                    stringToCardPropertiesTranslation.forEach {
                        arrayOfCards.append(SetCard(ofCharacter: $0.key, andHexColor: staticColor!))
                    }
                case .number:
                    let staticNumber = Number.randomNumber()
                    // For each Color
                    hexColor.forEach {
                        let color = $0.value
                        // For each Shape
                        characterArray.forEach {
                            // For each Shading
                            $0.forEach {
                                arrayOfCards.append(SetCard(ofCharacter: $0[staticNumber.index], andHexColor: color))
                            }
                        }
                    }
                case .shading:
                    let staticShading = Shading.randomShading()
                    // For each Color
                    hexColor.forEach {
                        let color = $0.value
                        // For each Shape
                        characterArray.forEach {
                            // For each Number (of the static shading)
                            $0[staticShading.index].forEach {
                                arrayOfCards.append(SetCard(ofCharacter: $0, andHexColor: color ))
                            }
                        }
                    }
                    
                case .shape:
                    let staticShape = Shape.randomShape()
                    // For each Color
                    hexColor.forEach {
                        let color = $0.value
                        // For each Shading (of this Shape)
                        characterArray[staticShape.index].forEach {
                            // For each Number
                            $0.forEach {
                                arrayOfCards.append(SetCard(ofCharacter: $0, andHexColor: color ))
                            }
                        }
                    }
                }
            }
        case .difficult, .medium:
            // if medium add hints or a SET count
            // still needs to be implemented...
            
            // Use all 4 properties
            arrayOfCards = []
            // for each color
            hexColor.forEach {
                let color = $0.value
                // for each string in dictionary
                stringToCardPropertiesTranslation.forEach {
                    arrayOfCards.append(SetCard(ofCharacter: $0.key, andHexColor: color))
                }
            }
        }
        return CardDeck(ofSet: arrayOfCards)
    }
}
