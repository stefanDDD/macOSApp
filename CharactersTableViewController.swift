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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersData = Characters(name:"characters_list.xml").charactersData
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.charactersData.count)
        return self.charactersData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let characterData = self.charactersData[indexPath.row]
        
        let imagePath = characterData.image
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: imagePath) {
            if let image = UIImage(contentsOfFile: imagePath) {
                cell.imageView?.image = image
            } else {
                cell.imageView?.image = UIImage(named: "defaultImage")
            }
        } else {
            cell.imageView?.image = UIImage(named: "defaultImage")
        }
        
        cell.textLabel?.text = characterData.name
        return cell
    }


}

