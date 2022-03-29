//
//  FavouritesTableViewController.swift
//  CiaraElizabethGriffin
//
//  Created by Ciara-Beth  on 17/03/2022.
//

import Foundation
import UIKit

// Create the FavouritesTableViewController class
class FavouritesTableViewController: UITableViewController {
    
    // Model data
    var characterList = [Character]()
    var charactersForTable : MovieCharacters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get the data to be used for the characters in this table by creating an instance of the MovieCharacters class
        charactersForTable = MovieCharacters(characterList)
        
    }
    
    // This function creates the number of sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // This function decides the numbers of rows in each section of the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count 
    }
    
   
    // This function returns a cell for each character in the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a cell constant
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        // Retrieve the data for the character for the current cell from the indexPath.row index of the data property of charactersForTable
        let characterData = charactersForTable.data[indexPath.row]
        // Set the text that should be displayed in the cell
        cell1.textLabel?.text = characterData.name
        // Set the colour of the cell's text
        cell1.textLabel?.textColor = UIColor.systemYellow
        // Set the text that should be displayed in the detailed text label in the cell
        cell1.detailTextLabel?.text = characterData.homePlanet
        // Set the colour of the detailed text label in the cell
        cell1.detailTextLabel?.textColor = UIColor.systemYellow
        // Display the character's image in the cell
        cell1.imageView?.image = UIImage(named: characterData.image)
        // return the cell
        return cell1
        
    }

    // This function prepares for the navigation that occurs when the user clicks on a character's cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1"{
            // set the destination of the segue to ViewController
            let destController = segue.destination as! ViewController
            // set the indexPath as the indexPath of the cell the user clicked on
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            // use the index path to determine which character's data should be pushed to the next view controller
            let characterData = charactersForTable.data[indexPath!.row]
            // push the data to the next view controller
            destController.characterData = characterData
        }
}
}
