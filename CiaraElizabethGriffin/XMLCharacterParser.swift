//
//  XMLCharacterParser.swift
//  CiaraElizabethGriffin
//
//  Created by Ciara-Beth  on 08/03/2022.
//

import Foundation

// Class to be used to parse an XML file that contains information about characters
class XMLCharacterParser : NSObject, XMLParserDelegate{
    // name variable to hold the file's name
    var name: String
    init(name:String){self.name = name}
    
    // Declaration of 'c' variables - variables that are named after the tags within the XML file but that are
    // start with the letter c to allow me to easily differenciate between variables belonging to the Person class,
    // and variables belonging to the XMLCharacterParser class
    var cName, cHomePlanet, cBirthYear, cEyeColour, cImage, cWebLink, cFirstFilm : String!
    
    // Declaration of an array of the tags used in the XML file
    let tags = ["firstFilm","name","homePlanet","birthYear","eyeColour","image","weblink"]
    
    // Starting values for elementID and passData are automatically -1 and false so that the application doesn't
    // run functions at the wrong time
    var elementID = -1
    var passData = false
    
    // Declaration of a characterData array, to hold the data extracted from the XML file
    var characterData = [Character]()
    // Declaration of arrays, an array for each trilogy and one for TV shows
    // tvCharacterData will hold data on characters who first appeared on a TV Show
    var tvCharacterData = [Character]()
    // originalTrilogyData will hold data on characters who first appeared in the original Star Wars trilogy (i.e. Episodes 4, 5 or 6)
    var originalTrilogyData = [Character]()
    // sequelTrilogyData will hold data on characters who first appeared in the sequel Star Wars trilogy (i.e. Episodes 1, 2 or 3)
    var sequelTrilogyData = [Character]()
    // newTrilogyData will hold data on characters who first appeared in the most recent Star Wars trilogy (i.e. Episodes 7, 8 or 9)
    var newTrilogyData = [Character]()
    // movieCharacterData will be used to add each individual character to the correct arrays
    var movieCharacterData : Character!
    
    var parser = XMLParser()
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // If the passData variable signals that this string is within a set of tags (i.e. passData == true)
        if passData{
            // Depending on what elementID has been assigned
            switch elementID {
                // If elementID == 0, store the string in the cName variable
                case 0 : cName = string
                // If elementID == 1, store the string in the cHomePlanet variable
                case 1 : cHomePlanet = string
                // If elementID == 2, store the string in the cBirthYear variable
                case 2 : cBirthYear = string
                // If elementID == 3, store the string in the cEyeColour variable
                case 3 : cEyeColour = string
                // If elementID == 4, store the string in the cImage variable
                case 4 : cImage = string
                // If elementID == 5, store the string in the cWebLink variable
                case 5 : cWebLink = string
                // If elementID == 5, store the string in the cWebLink variable
                case 6 : cFirstFilm = string
                // If elementID != 1 or 2 or 3 or 4 or 5, break the switch statement
                default: break
                
            }
        }
    }
    
    // This function is run when a closing tag is detected (i.e. didEndElement)
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // If the closing tags contain the elementName
       if tags.contains(elementName){
            // Reset passData to false, and elementID to -1
            passData = false
            elementID = -1
        }
        // If the elementName in the closing tags is "character"
        if elementName == "character"{
            // Create an instance of the Person class and call it personData
            movieCharacterData = Character(firstFilm: cFirstFilm, name: cName, homePlanet: cHomePlanet, birthYear: cBirthYear, eyeColour: cEyeColour, image: cImage, weblink: cWebLink)
            // Switch statement to determine which of the trilogy arrays the character should be added to
            switch cFirstFilm {
                // in case 1, 2 and 3, the character should be added to the sequelTrilogy array
            case "1": sequelTrilogyData.append(movieCharacterData)
            case "2": sequelTrilogyData.append(movieCharacterData)
            case "3": sequelTrilogyData.append(movieCharacterData)
                    // in case 4, 5 and 6, the character should be added to the originalTrilogy array
            case "4": originalTrilogyData.append(movieCharacterData)
            case "5": originalTrilogyData.append(movieCharacterData)
            case "6": originalTrilogyData.append(movieCharacterData)
                // in case 7, 8 and 9, the character should be added to the newTrilogy array
            case "7": newTrilogyData.append(movieCharacterData)
            case "8": newTrilogyData.append(movieCharacterData)
            case "9": newTrilogyData.append(movieCharacterData)
                // in case "TV" the character should be added to the TV character array
            case "TV": tvCharacterData.append(movieCharacterData)
            default:
                break
                }
        // Add personData to the characterData array, regardless of what film they first appeared in
        characterData.append(movieCharacterData)
            }
        }
        
    
    
    // This function runs when opening tags are detected
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // If the opening tags contain an elementName
        if tags.contains(elementName){
            // Set the passData variable to true
            passData = true
            // Switch statement determines elementID based on the elementName
            switch elementName {
                case "name"         : elementID = 0
                case "homePlanet"   : elementID = 1
                case "birthYear"    : elementID = 2
                case "eyeColour"    : elementID = 3
                case "image"        : elementID = 4
                case "weblink"      : elementID = 5
                case "firstFilm"    : elementID = 6
                default: break
                
            }
        }
    }
    
    func parsing(){
        // Declare bundleURL as the bundleURL of the bundle of the code that's currently executing
        let bundleURL = Bundle.main.bundleURL
        // This constant contains the URL of the XML file to be read
        let fileURL = URL(fileURLWithPath: self.name, relativeTo: bundleURL)
        // Create an Instance of the XMLParser class called parser
        parser = XMLParser(contentsOf: fileURL)!
        parser.delegate = self
        
        // Call the in-built parse() function for the parser instance of the XMLParser class
        parser.parse()
    }
    
}
