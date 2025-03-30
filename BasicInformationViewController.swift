//
//  BasicInformationViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation
import UIKit

class BasicInformationViewController: UIViewController{
    
    var characterData: Character?
    
    // MARK: - outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - actions
    @IBAction func moreInfoButton(_ sender: UIButton) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = characterData?.name
        imageView.image = UIImage(named: characterData!.image)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAllInfo" {
            if let destController = segue.destination as? AllInfoViewController {
                destController.characterData = self.characterData
            }
        }
    }

}
