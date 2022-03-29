//
//  DetailsViewController.swift
//  Person Information
//
//  Created by stabirca on 15/02/2021.
//  Edited and Expanded upon by Ciara Elizabeth Griffin on 21/02/2022.
//

import UIKit
import WebKit

// Create a UIViewController class called DetailsViewController
class DetailsViewController: UIViewController {

    // Name Text Field Outlet
    @IBOutlet weak var nameTextField: UITextField!
    // Home Planet Text Field Outlet
    @IBOutlet weak var homePlanetTextField: UITextField!
    // Birth Year Text Field Outlet
    @IBOutlet weak var birthYearTextField: UITextField!
    // Eye Colour Text Field Outlet
    @IBOutlet weak var eyeColourTextField: UITextField!
    
    
    // model object
    var characterData: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the text in the name text field to match the name property of characterData
        nameTextField.text = characterData.name
        // Set the text in the home planet text field to match the homePlanet property of characterData
        homePlanetTextField.text = characterData.homePlanet
        // Set the text in the eye colour text field to match the eyeColour property of characterData
        eyeColourTextField.text = characterData.eyeColour
        // Set the text in the birth year text field to match the birthYear property of characterData
        birthYearTextField.text = characterData.birthYear
   
    }
    

    
    // Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         // Check that the segue identifier is correct
         if segue.identifier == "segue1"{
             // Set the destination as WebViewController
             let destController = segue.destination as! WebViewController
             
             // Push the data to destination
             destController.characterData = characterData
         }
         
     }
}
