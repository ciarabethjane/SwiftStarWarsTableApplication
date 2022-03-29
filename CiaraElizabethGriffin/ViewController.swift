//
//  ViewController.swift
//  CiaraElizabethGriffin
//
//  Created by Ciara-Beth  on 17/03/2022.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    // Name Text Field Outlet
    @IBOutlet weak var nameLabel: UILabel!
    // Home Planet Text Field Outlet
    @IBOutlet weak var charImage: UIImageView!
    
    @IBOutlet weak var homePlanetLabel: UILabel!
    // model object
    var characterData: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the text in the name text field to match the name property of personData
        nameLabel.text = characterData.name
        homePlanetLabel.text = characterData.homePlanet
        // Set the text in the home planet text field to match the homePlanet property of personData
        charImage?.image = UIImage(named: characterData.image)
    }
    

    
    // Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         // Check that the segue identifier is correct
         if segue.identifier == "segue1"{
             // Set the destination as DetailsViewController
             let destController = segue.destination as! DetailsViewController
             // Push the data to destination
             destController.characterData = characterData
         }
         
     }
}
