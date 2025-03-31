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
        
        charactersData = Characters(name: "characters_list.xml").charactersData
        
        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill

        tableView.backgroundView = imageViewbg
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
        
        if let image = UIImage(named: characterData.image) {
            cell.imageView?.image = image
        }
        
        DispatchQueue.main.async {
            if let imageView = cell.imageView {
                imageView.layer.cornerRadius = imageView.frame.size.width / 2
                imageView.clipsToBounds = true
            }
        }
        
        cell.textLabel?.text = characterData.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
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

