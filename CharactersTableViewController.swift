//
//  CharactersTableViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation
import UIKit

class CharactersTableViewController: UITableViewController {
    var charactersData: [Character]!
    var characterData: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parserBundle = XMLCharactersParser(name: "characters_list.xml")
        parserBundle.parsing()
        let parserDocuments = XMLCharactersParser(name: "characters_list.xml")
        parserDocuments.parsing(fromDocuments: true)
        charactersData = parserBundle.charactersData + parserDocuments.charactersData
        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill

        tableView.backgroundView = imageViewbg
        styleBreakingBadTableView()
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
        if let image = loadImage(named: characterData.image) {
            cell.imageView?.image = image
        }
        
        DispatchQueue.main.async {
            if let imageView = cell.imageView {
                imageView.layer.cornerRadius = imageView.frame.size.width / 2
                imageView.clipsToBounds = true
                
                imageView.layer.borderWidth = 1
                imageView.layer.borderColor = UIColor.green.cgColor
            }
        }

        cell.textLabel?.text = characterData.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(white: 0.3, alpha: 0.6)
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.masksToBounds = true
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
    
    func styleBreakingBadTableView() {
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.backgroundColor = UIColor.clear
        let tableViewHeight: CGFloat = 300
        tableView.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: tableViewHeight)
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(white: 0.8, alpha: 1)
        
        tableView.cellLayoutMarginsFollowReadableWidth = false
    }
    
    func loadImage(named imageName: String) -> UIImage? {
        if let image = UIImage(named: imageName) {
            return image
        }
        
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let imageURL = documentsDirectory.appendingPathComponent(imageName)
        if let image = UIImage(contentsOfFile: imageURL.path) {
            return image
        }
        
        return nil
    }
}
