//
//  People.swift
//  CiaraElizabethGriffin
//
//  Created by Ciara-Beth  on 20/02/2022.
//

import Foundation

// Create a class called People
class MovieCharacters {
    // declare a variable called data of type array, containing instances of the Person class
    var data : [Character]!
    var tvCharacterData : [Character]!
    var originalTrilogyData : [Character]!
    var sequelTrilogyData : [Character]!
    var newTrilogyData : [Character]!

    init(_ data: [Character]){
        self.data = data}
    // initialiser for the People class
    init(fromXMLFile: String){
        // Create an instance of the XMLCharacterParser class to parse through the XML file that's name is passed as a parameter
        let parser = XMLCharacterParser(name: fromXMLFile)
        parser.parsing()
        
        // This classes data is contained in the characterData variable of the parser instance of the XMLCharacterParser class
        self.tvCharacterData = parser.tvCharacterData
        self.originalTrilogyData = parser.originalTrilogyData
        self.sequelTrilogyData = parser.sequelTrilogyData
        self.newTrilogyData = parser.newTrilogyData
        self.data = parser.characterData
        
    }
    // This function will return the length of the entire list of characters, without taking into account which trilogy they first appeared in
    func dataLength()->Int{return self.data.count}
    // This function will return the index of the character
    func movieCharacterData(index:Int)->Character{return self.data[index]}
}
