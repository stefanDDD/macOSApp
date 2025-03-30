//
//  AllInfoViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation
import UIKit

class AllInfoViewController: UIViewController{
    
    var characterData: Character?
    
    // MARK: - outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    // MARK: - actions
    @IBAction func urlViewButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = characterData?.name
        aliasLabel.text = characterData?.alias
        actorLabel.text = characterData?.actor
        if let imageName = characterData?.image {
            imageView.image = UIImage(named: imageName)
        }
        roleLabel.text = characterData?.role
        quoteLabel.text = characterData?.quote
        urlLabel.text = characterData?.url
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sequeDisplayURL" {
            if let destController = segue.destination as? UrlViewController {
                destController.characterData = self.characterData
            }
        }
    }
}
