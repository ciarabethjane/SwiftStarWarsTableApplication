//
//  CharacterTableViewController.swift
//  CiaraElizabethGriffin
//
//  Created by Ciara-Beth  on 19/02/2022.

// Import UIKit Library
import UIKit


// Create a class called CharacterTableViewController, of type UITableViewController
class CharacterTableViewController: UITableViewController {

    // Declare a peopleData variable
    var movieCharacterData : MovieCharacters!
    var favouriteCharacterData = [Character]()
    var cellCounter = 0
    var userFavouriteCharactersIndices = [Int]()
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemYellow]
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        // Create an instance of the People class, which should contain data from the XML file, characters.xml
        movieCharacterData = MovieCharacters(fromXMLFile: "characters.xml")
      
       
    }

// This function is used to enable the user to add characters to their favourites list by swiping from left to right
override func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // declaring a constant to signal that the user has swiped from left to right
    // when the user swipes from left to right it calls the private method handleMarkAsFavourite
        let action = UIContextualAction(style: .normal,
                                        title: "Favourite", handler: { (action, view, completionHandler) in
            self.handleMarkAsFavourite(indexPath)
                                            completionHandler(true)
                                         
            
        }
                                        )
        // When the user swipes from left to right, the cell they've swiped should turn yellow while they're swiping
        action.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [action])
        }
    
    // Function to be called when user swipes to add a character to their favourites list
    private func handleMarkAsFavourite(_ indexPath: IndexPath) {
        // Print "Marked as favourite" to output on XCode
        print("Marked as favourite")
            // Create a variable to hold the index number of the relevant character
            var indexVal = 0
            // If the cell the user swiped was in section 0
            if indexPath[0] == 0{
                // The indexVal only needs to take into account the row index of the index path
                indexVal = indexPath.row
                // If the indexVal in question hasn't already been added to the userFavouriteCharactersIndices list, add it to the list
                if !userFavouriteCharactersIndices.contains(indexVal){
                userFavouriteCharactersIndices.append(indexVal)
                }
            }
            // If the cell the user swiped was in section 1
            if indexPath[0] == 1{
                // The indexVal needs to account for the fact that each time a new section is started, the row index resets to zero, therefore, it should add the total number of cells in section 0 to the row index to get an accurate value for the index of the relevant character in the array containing the data of every character
                indexVal = indexPath.row + movieCharacterData.tvCharacterData.count
                // If the indexVal in question hasn't already been added to the userFavouriteCharactersIndices list, add it to the list
                if !userFavouriteCharactersIndices.contains(indexVal){
                    userFavouriteCharactersIndices.append(indexVal)}
            }
            // If the cell the user swiped was in section 2
            if indexPath[0] == 2{
                // The indexVal needs to account for the fact that each time a new section is started, the row index resets to zero, therefore, it should add the total number of cells in section 0 and section 1 to the row index to get an accurate value for the index of the relevant character in the array containing the data of every character
                indexVal = indexPath.row + movieCharacterData.tvCharacterData.count + movieCharacterData.originalTrilogyData.count
                // If the indexVal in question hasn't already been added to the userFavouriteCharactersIndices list, add it to the list
                if !userFavouriteCharactersIndices.contains(indexVal){
                userFavouriteCharactersIndices.append(indexVal)
                }}
            // If the cell the user swiped was in section 3
            if indexPath[0] == 3{
                // The indexVal needs to account for the fact that each time a new section is started, the row index resets to zero, therefore, it should add the total number of cells in section 0, section 1 and section 2 to the row index to get an accurate value for the index of the relevant character in the array containing the data of every character
                indexVal = indexPath.row + movieCharacterData.tvCharacterData.count + movieCharacterData.originalTrilogyData.count + movieCharacterData.sequelTrilogyData.count
                // If the indexVal in question hasn't already been added to the userFavouriteCharactersIndices list, add it to the list
                if !userFavouriteCharactersIndices.contains(indexVal){
                userFavouriteCharactersIndices.append(indexVal)
                }}
        }
    // function to create an array of the user's favourite characters
   private func creationOfFavouritesList(_ userFavouriteCharactersIndices:[Int])->[Character]{
       // For loop to cycle through the userFavouriteCharactersIndices list
        for i in 0...userFavouriteCharactersIndices.count - 1{
            // Create a constant to hold the data belonging to the character found at the index of userFavouriteCharactersIndices[i] in the array containing every character's data
            let currentChar = movieCharacterData.movieCharacterData(index: userFavouriteCharactersIndices[i])
            // add the contents of currentChar to the favouriteCharacterData array
            favouriteCharacterData.append(currentChar)
            }
       // return the favouriteCharacterData array
        return favouriteCharacterData
    }
    
    // This function determines the number of sections in the tableView. I assigned this manually based on the number of categories of characters there would be in the XML file
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    // This function determines the headers for each section based on the section index
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if section == 0 {
            // return "TV Characters" as a header
            return "TV Characters"
            }
        if section == 1{
            // return "Original Trilogy Characters" as a header
            return "Original Trilogy Characters"
        }
        if section == 2{
            // return "Sequel Trilogy Characters" as a header
            return "Sequel Trilogy Characters"
        }else {
            // return "New Trilogy Characters" as a header
            return "New Trilogy Characters"
          }
    }
    
    
    // This function returns the number of rows that should be in each section of the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // return the number of characters with "TV" listed as their firstFilm variable as the number of rows that should be in section 0
            return movieCharacterData.tvCharacterData.count
            }
        if section == 1{
            // return the number of characters with "3", "4" or "5" listed as their firstFilm as the number of rows that should be in section 1
            return movieCharacterData.originalTrilogyData.count
        }
        if section == 2{
            // return the number of characters with "1", "2" or "3" listed as their firstFilm as the number of rows that should be in section 2
            return movieCharacterData.sequelTrilogyData.count
        }
        else {
            // return the number of characters with "6", "7" or "8" listed as their firstFilm as the number of rows if not in section 0, 1 or 2
            return movieCharacterData.newTrilogyData.count
          }
    }

    // This function will return a cell for each character
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a cell constant
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // if the value of cellCounter is less than the value of the total number of characters
        let sectionNum = indexPath[0]
        // if sectionNum is equal to 0
        if sectionNum == 0{
            // the rowNum doesn't need to account for the number of rows in previous sections, so we can just use indexPath.row
            let rowNum = indexPath.row
            // Get the data that's at the index of rowNum in movieCharacterData.movieCharacterData
            let characterData = movieCharacterData.movieCharacterData(index: rowNum)
            // Set the text that should be displayed in the cell
            cell.textLabel?.text = characterData.name
            // Set the colour of the cell's text
            cell.textLabel?.textColor = UIColor.systemYellow
            // Set the text that should be displayed in the detailed text label in the cell
            cell.detailTextLabel?.text = characterData.homePlanet
            // Set the colour of the detailed text label in the cell
            cell.detailTextLabel?.textColor = UIColor.systemYellow
            // Display the character's image in the cell
            cell.imageView?.image = UIImage(named: characterData.image)
            }
        // if sectionNum is equal to 1
        if sectionNum == 1{
            // To get the right character's data from the array containing the data of all characters, we need to account for the number of rows in the previous section when supplying the index of the character's data
            let rowNum = indexPath.row + movieCharacterData.tvCharacterData.count
            let characterData = movieCharacterData.movieCharacterData(index: rowNum)
            // Set the text that should be displayed in the cell
            cell.textLabel?.text = characterData.name
            // Set the colour of the cell's text
            cell.textLabel?.textColor = UIColor.systemYellow
            // Set the text that should be displayed in the detailed text label in the cell
            cell.detailTextLabel?.text = characterData.homePlanet
            // Set the colour of the detailed text label in the cell
            cell.detailTextLabel?.textColor = UIColor.systemYellow
            // Display the character's image in the cell
            cell.imageView?.image = UIImage(named: characterData.image)
            }
        // if sectionNum is equal to 2
        if sectionNum == 2{
            // To get the right character's data from the array containing the data of all characters, we need to account for the number of rows in the previous 2 sections when supplying the index of the character's data
            let rowNum = indexPath.row + movieCharacterData.tvCharacterData.count + movieCharacterData.originalTrilogyData.count
            let characterData = movieCharacterData.movieCharacterData(index: rowNum)
            // Set the text that should be displayed in the cell
            cell.textLabel?.text = characterData.name
            // Set the colour of the cell's text
            cell.textLabel?.textColor = UIColor.systemYellow
            // Set the text that should be displayed in the detailed text label in the cell
            cell.detailTextLabel?.text = characterData.homePlanet
            // Set the colour of the detailed text label in the cell
            cell.detailTextLabel?.textColor = UIColor.systemYellow
            // Display the character's image in the cell
            cell.imageView?.image = UIImage(named: characterData.image)
            }
        // if sectionNum is equal to 3
        if sectionNum == 3{
            // To get the right character's data from the array containing the data of all characters, we need to account for the number of rows in the previous 3 sections when supplying the index of the character's data
            let rowNum = indexPath.row + movieCharacterData.tvCharacterData.count + movieCharacterData.originalTrilogyData.count + movieCharacterData.sequelTrilogyData.count
            let characterData = movieCharacterData.movieCharacterData(index: rowNum)
            // Set the text that should be displayed in the cell
            cell.textLabel?.text = characterData.name
            // Set the colour of the cell's text
            cell.textLabel?.textColor = UIColor.systemYellow
            // Set the text that should be displayed in the detailed text label in the cell
            cell.detailTextLabel?.text = characterData.homePlanet
            // Set the colour of the detailed text label in the cell
            cell.detailTextLabel?.textColor = UIColor.systemYellow
            // Display the character's image in the cell
            cell.imageView?.image = UIImage(named: characterData.image)
            }
        // Return the cell
        return cell
    }
    
    
        
    
    // initiate the rowIndex
    var rowIndex = -1
    
    // Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the segue's identifier matches the string "segue1"
        if segue.identifier == "segue1"{
            // Set the destination of the segue to the ViewController
            let destController = segue.destination as! ViewController
            //Find the indexPath of Sender
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            // Pass the data associated with the character of the selected cell to the destination controller
            let sectionNo = indexPath![0]
            let rowNo = indexPath!.row
            if sectionNo == 1{
                // Take into account rows in previous sections when calculating the index of the data of the selected character
                rowIndex = rowNo + movieCharacterData.tvCharacterData.count
                let characterData = movieCharacterData.movieCharacterData(index: rowIndex)
                destController.characterData = characterData
            }
            if sectionNo == 2{
                // Take into account rows in previous sections when calculating the index of the data of the selected character
                rowIndex = rowNo + movieCharacterData.tvCharacterData.count + movieCharacterData.originalTrilogyData.count
                let characterData = movieCharacterData.movieCharacterData(index: rowIndex)
                destController.characterData = characterData
            }
            if sectionNo == 3{
                // Take into account rows in previous sections when calculating the index of the data of the selected character
                rowIndex = rowNo + movieCharacterData.tvCharacterData.count + movieCharacterData.originalTrilogyData.count + movieCharacterData.sequelTrilogyData.count
                let characterData = movieCharacterData.movieCharacterData(index: rowIndex)
                destController.characterData = characterData
            }
            if sectionNo == 0{
                rowIndex = rowNo
                let characterData = movieCharacterData.movieCharacterData(index: rowIndex)
                destController.characterData = characterData
            }
        }
        // if the segue's identifier matches the string "segue2"
        if segue.identifier == "segue2"{
            // Set the FavouritesTableViewController as the destination controller
            let destController = segue.destination as! FavouritesTableViewController
            // call creationOfFavouritesList() to retrieve the data of the user's favourite characters
            let characterData2 = self.creationOfFavouritesList(userFavouriteCharactersIndices)
            // reset the userFavouriteCharactersIndices to be an empty list
            userFavouriteCharactersIndices = [Int]()
            // push the relevant data through to the destination controller
            destController.characterList = characterData2
        }
 
    }
    
}


    

    


