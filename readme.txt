Student Name: Ciara Elizabeth Griffin 	
Student Number: 118418136

This application presents information to the user about 18 of the characters from the Star Wars film franchise. I based some of my code on resources I found online, links to which can be found at the end of this document. This application was built using XCode 13.2.1, and tested using the iPhone 8 Plus simulator.

-----------------------------------------------------------------------------------------------------

Overview of Personal Technical Contributions:
I elaborate on each of the following technical contributions in both the comments in the code files and later in this report.

1. I added a launch screen image of a graphic sourced online representing what it looks like to travel through hyperspace in the Star Wars universe. I did this by creating a very basic LaunchScreenViewController class that contains a function to load the launch screen.

2. I changed the colours of the UI Elements of the application to black (for anything in the background) and yellow (for anything in the foreground such as text, buttons and navigation elements) as these are the most prominent colours in the Star Wars Logo. This is consistent throughout the entire application.

2. I added sections to the initial TableViewController to separate the characters based on what film they first appeared in. I did this by adding a "firstFilm" property to each character. The number of rows in each section is determined by the length of an array of characters relevant to a given section (e.g. the number of rows in the "TV Characters" section is determined by the length of the array containing characters who made their first appearance in a TV show).

3. Sliding any cell in the initial "CharacterTableViewController" from left to right adds the character in that cell to a "Favourites" List, provided that character isn't already included in the Favourites list. When the user slides the cell from left to right, part of the cell turns yellow and displays a text label of "Favourite" to indicate to the user that this character has been added to the favourites. Because of time constraints, I chose to implement this with arrays instead of Core Data files. As such, favourites are only remembered until the user closes the application. I was also unable to include a "remove from favourites" option, due to time constraints.

4. A button at the bottom of the initial CharacterTableViewController labelled "View Favourites" has been added. When pressed by the user, the application navigates to a FavouritesTableViewController containing a table of only characters who have been added to the user's favourites list. Any cell selected from the favourites table brings the user to the next viewController (displaying character's image and name) just as the same interaction on the initial table view would.

5. I added a loadingView and activityIndicatorView to the WebViewController, so that an animated loading icon is displayed on the user's screen while the relevant character's webpage is loaded

-----------------------------------------------------------------------------------------------------

LaunchScreenViewController.swift

A very basic UIViewController class to load the LaunchScreen when the application is opened. Contains only a viewDidLoad() method

-----------------------------------------------------------------------------------------------------

Character.swift

Character.swift is code that was adapted from the "Person" class in the lab exercises to contain the Character class, which contains a list of properties that are relevant for each character and their associated pages within the application, and an initialiser function to initialise each instance of the class.

-----------------------------------------------------------------------------------------------------

XMLCharacterParser.swift

XMLCharacterParser.swift contains the XMLCharacterParser class, which can be used to parse an XML file and read in the data from that file. I declare a number of 'c' variables, which are named after the tags within the XML file, but start with the letter c to allow me to easily differentiate variables belonging to the Character class and variables belonging to the XMLCharacterParser class. I also declare an array of the tags used within the xml file. I declare the elementID variable and the passData variable, which are assigned starting values of -1 and false so that the application doesn't start parsing data at the wrong time. I create an array called characterData, that will hold the data for every character that's extracted from the XML file. I also create an array for each Star Wars Trilogy, as well as an array for Star Wars TV Shows. These arrays will only hold characters who made their first appearance in the trilogy/tv show specific to that array. 

Each item in the array will follow the format of the Character class. I create an instance of the in-built XMLParser class and called it parser. In the first parser function, it checks if the passData variable signals that this string is within a set of tags. It then uses a switch statement to assign the string that is enclosed within these tags to one of the cVariables, depending on which elementID it has been assigned. 

The second function in this file is run when a closing tag is detected. It uses an if statement to check if the closing tags contain the elementName, and if it does, it resets the value of passData to false and elementID to -1. It then uses an if statement to check if the elementName in the closing tags is "person" and if it is, it creates an instance of the Person class using the cVariables as parameters for the properties. It then adds personData to the characterData array. 

The third function in this file is run when opening tags are detected, and it uses an if statement to determine if the opening tags contain an elementName. If an elementName is detected, the value of passData is set to true and a switch statement assigns an elementID based on the elementName (e.g. if elementName is "name" then the elementID is 0). 

The final function in this class is called parsing. It declares the bundleURL as the bundleURL of the bundle of the code that's currently executing, and then declares a constant called fileURL to contain the URL of the XML file to be read. It then creates and instance of the XMLParser class called parser, and calls the in-built parse() function for the parser instance of the XMLParser class. 

-----------------------------------------------------------------------------------------------------

MovieCharacters.swift

MovieCharacters.swift contains the MovieCharacter class, where an array called data is declared, which will contain instances of the Character class. It also contains arrays of the characters based on the trilogy they first appeared in, again with each item in the array being an instance of the Character class. 

The first initialiser function in the file takes a list of instances of the Character class as a parameter. This is the initialiser used when creating the list of characters to be displayed in the Favourites table.

I also created another initialiser function for the MovieCharacters class, which creates an instance of the XMLCharacterParser class to parse through the XML file that's name is passed as a parameter. This is what's used for creating the table of all of the characters found in the XML file.

The dataLength function will return the length of the data and the personData function will return the index of each character.

-----------------------------------------------------------------------------------------------------

CharacterTableViewController.swift

CharacterTableViewController.swift contains the CharacterTableViewController class. 

The viewDidLoad() function first sets up the colour scheme of the navigation controller. It then creates an instance of the Character class, which should contain data from the XML file characters.xml. 

The next function in this file is used to allow the user to add characters to their favourites list by swiping from left to right. When the user performs a left to right swipe on a cell, that cell temporarily turns partially yellow and displays a label "Favourite" to signal to the user that they have added that character to their favourites list. It also calls the private method handleMarkAsFavourite()

The handleMarkAsFavourite() method prints "Marked as Favourite" to the output window in XCode, and then adds the index of the relevant character's data to a list of indices to be used later. Because each new section resets the rowIndex to 0, I've coded this method to check the section from the indexPath that's passed as a parameter. If the user has swiped a cell in section 1,2 or 3, the integer that's added to the list of indices is calculated using the sum of the number of rows in all previous sections, plus the indexPath.row of the selected cell. This ensures that when the list of userFavouriteCharactersIndices is used to retrieve the data of the user's favourite characters from the array containing the data of all characters in the table, the index matches the index of the same character.

The creationOfFavouritesList() method cycles through the list of the indices of the characters the user favourited. In each iteration, the loop assigns a constant to hold the data of the character that's found at the index of userFavouriteCharactersIndices[i] in the array containing the data of every character in the data. It then adds that data to the array favouriteCharacterData, and moves on to the next iteration. When the loop has concluded, the method returns the array favouriteCharacterData.

The numberOfSections function determines the number of sections in the tableView. I set this value manually based on the number of characters I knew there would be in the xml file.

The method after numberOfSections() in the file determines the headers for each section based on the section index.

The function below it in the file returns the number of rows that should be in each section of the tableView. This is calculated based on the number of characters that have been added to the array that corresponds to each section (e.g. the length of the tvCharacterData array determines the number of rows in the "TV Character" section of the table, etc.).

The next method in the file returns a cell for each character, which creates a cell constant, retrieves the data for the cell. It sets a textLabel for the character's name. and sets the colour of the textLabel to yellow. It also sets a detailTextLabel for the character's home planet, and sets the colour of the detailTextLabel to yellow. It sets the characters image to be displayed in the cell, and then returns the cell. Like previous methods, this method also takes into account whether the number of rows in previous sections need to be taken into account before passing a value as an index to retrieve the character's data from the array containing every character in the table. 

The final function in the file prepares for navigation. It first checks the value of the segue identifier. If the segue identifier is segue1, it sets the destination of the segue to the ViewController, finds the indexPath of the sender and then passes the data associated with the character of the selected cell to the destination controller. If the segue identifier is segue2, then the destination of the segue is set to the FavouritesTableViewController, the data to be pushed to the destination controller is created using creationOfFavouritesList(), the userFavouriteCharactersIndices list is reset to be an empty list, and the relevant data is pushed to the destination controller.

-----------------------------------------------------------------------------------------------------

FavouritesTableViewController.swift

FavouritesTableViewController.swift contains the FavouritesTableViewController class, which is largely the same as the CharacterTableViewController class, but with a few minor adjustments. It creates an instance of the MovieCharacters class from the list of favourited characters data that was passed from the initial view controller. This tableViewController only has 1 section for data (to display all of the user's favourited characters) instead of having them separated by trilogy. It creates the number of rows in the table that matches the total number of characters that have been favourited. It creates a cell for each favourited character. If the user clicks on a character's cell in this view controller, it prepares for navigation to the next viewController (i.e. the viewController that displays the character's image, name and homePlanet in a full screen) by  setting the destination of the segue to the ViewController, finds the indexPath of the sender and then passes the data associated with the character of the selected cell to the destination controller.

-----------------------------------------------------------------------------------------------------

ViewController.swift


ViewController.swift contains the ViewController class, which contains outlets to the image view and the name label in the main.storyboard file. The viewDidLoad() function uses the data that was pushed from the previous viewController to present the relevant character information on screen. The final function in this file prepares for the segue to the next view controller, and is virtually the same as the final function in the CharacterTableViewController file, except in this case the destination is the DetailsViewController.

-----------------------------------------------------------------------------------------------------

DetailsViewController.swift

DetailsViewController.swift contains the DetailsViewController class, which contains outlets to 4 UITextFields, one for the characters name, home planet, birth year and eye colour. The viewDidLoad function sets the text in the name text field to match the name property of characterData, the text in the home planet text field to match the homePlanet property of characterData, the eyeColour text field to match the eyeColour property of characterData and the birthYear text field to match the birthYear property of characterData. Again, the function preparing for the next segue is largely the same as the what's been discussed previously, but with the destination set to WebViewController.

-----------------------------------------------------------------------------------------------------

WebViewController.swift

WebViewController.swift contains the WebViewController class. It contains a loadingView, which is a UIView and an activityIndicator which is a UIActivityIndicator that will be displayed when content is loading via the internet. It also contains a WKWebView. The ViewDidLoad method calls the showSpinner method (which I'll elaborate on momentarily), as well as setting up personurl to contain the weblink belonging to the relevant character. theurl is set to create a URL from the string contained in personurl, and then the webView loads the webpage located at the URL contained in theurl. The showSpinner method is used to display the loadingView and animate the activity indicator. I then extended the WebViewController class to contain a method that checks if the webpage has been loaded, and if it has, it stops the animation of the activity indicator and hides the loadingView. 

-----------------------------------------------------------------------------------------------------

characters.xml

characters.xml is the XML file containing the character details for each character.

-----------------------------------------------------------------------------------------------------

Sources
In building my application, I based some of my code on code from the following sources:

Creating the launch screen
https://developer.apple.com/documentation/xcode/specifying-your-apps-launch-screen/
https://www.youtube.com/watch?v=FdiqRol8weU

Changing the colour of the text in the tableview
https://stackoverflow.com/questions/37518214/how-to-change-the-color-of-text-in-a-tableview-swift

Changing the Colour of elements in the Navigation bar to be coherent with the themes elsewhere in the application
https://stackoverflow.com/questions/24687238/changing-navigation-bar-color-in-swift
https://stackoverflow.com/questions/43706103/how-to-change-navigationitem-title-color

Adding Characters to the user's favourites list
https://programmingwithswift.com/uitableviewcell-swipe-actions-with-swift/
https://medium.com/nerd-for-tech/swift-uitableview-swipe-actions-4c1069d5717c
https://stackoverflow.com/questions/65366436/add-to-favorite-using-custom-tableviewcell-via-uibutton-save-to-userdefaults

Checking if a character's data has already been added to the list of FavouriteCharacterIndices
https://stackoverflow.com/questions/54760102/xcode-swift-is-there-an-opposite-to-contains

Creating the WebViewController
https://www.hackingwithswift.com/read/4/2/creating-a-simple-browser-with-wkwebview
https://www.appypie.com/wkwebview-how-to
https://developer.apple.com/documentation/webkit/wknavigationdelegate

Creating the LoadingView and the ActivityIndicator
https://www.raywenderlich.com/25358187-spinner-and-progress-bar-in-swift-getting-started#toc-anchor-001
https://www.hackingwithswift.com/example-code/uikit/how-to-use-uiactivityindicatorview-to-show-a-spinner-when-work-is-happening
https://stackoverflow.com/questions/40819656/how-to-add-activity-indicator-to-wkwebview-swift-3





