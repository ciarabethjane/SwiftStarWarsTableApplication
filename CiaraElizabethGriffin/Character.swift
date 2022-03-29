//
//
//  Person.swift Created by stabirca on 15/02/2021.
//  Adapted by Ciara Elizabeth Griffin 19/02/2022.
//  Character.swift
//

import Foundation

class Character{
    
    // properties relevant for each character and their associated pages within the application
    var name : String
    var homePlanet : String
    var birthYear : String
    var eyeColour : String
    var image : String
    var weblink : String
    var firstFilm : String
    
    // initialiser for the Person class
    init(firstFilm:String, name:String, homePlanet:String, birthYear:String, eyeColour:String, image:String, weblink:String){
        self.name = name
        self.homePlanet = homePlanet
        self.birthYear = birthYear
        self.eyeColour = eyeColour
        self.image = image
        self.weblink = weblink
        self.firstFilm = firstFilm
    }
    
}
