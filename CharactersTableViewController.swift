//
//  CharactersTableViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation
import UIKit

class CharactersTableViewController: UITableViewController{
    var charactersData: [Character]!
    var characterData: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersData = Characters(name:"characters_list.xml").charactersData
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charactersData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let characterData = self.charactersData[indexPath.row]
        
        cell.imageView?.image = UIImage(named: characterData.image)
        cell.textLabel?.text = characterData.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueBasicInformation" {
            if let destController = segue.destination as? BasicInformationViewController {
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                    characterData = charactersData[indexPath.row]
                    destController.characterData = self.characterData
                }
            }
        }
    }

}

