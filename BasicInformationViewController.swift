//
//  BasicInformationViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation
import UIKit

class BasicInformationViewController: UIViewController {
    
    var characterData: Character?

    // MARK: - outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var moreInfoButtonStyle: UIButton!

    // MARK: - actions
    @IBAction func moreInfoButton(_ sender: UIButton) {
        // Your action logic here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewbg)
        self.view.sendSubviewToBack(imageViewbg)
        
        if let character = characterData {
            styleNameLabel(label: self.nameLabel, data: character.name)
            styleImageView(imgView: self.imageView)
            styleBreakingBadButton(button: self.moreInfoButtonStyle)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAllInfo" {
            if let destController = segue.destination as? AllInfoViewController {
                destController.characterData = self.characterData
            }
        }
    }

    func styleBreakingBadButton(button: UIButton) {
        button.backgroundColor = UIColor(red: 30/255, green: 50/255, blue: 30/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 4
        button.bounds.size = CGSize(width: 160, height: 60)
    }

    func styleImageView(imgView: UIImageView) {
        imgView.layer.cornerRadius = imgView.frame.width / 2
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        
        if let image = UIImage(named: characterData!.image) {
            imgView.image = image
        } else {
            imgView.image = loadImage(named: characterData!.image)
        }
        
        imgView.layer.borderWidth = 3
        imgView.layer.borderColor = UIColor.green.cgColor
        
        imgView.layer.shadowColor = UIColor.black.cgColor
        imgView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imgView.layer.shadowOpacity = 0.7
        imgView.layer.shadowRadius = 6
        imgView.alpha = 0.9
    }

    func styleNameLabel(label: UILabel, data: String) {
        label.text = data
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 4
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(white: 0.4, alpha: 0.7)
    }

    func loadImage(named imageName: String) -> UIImage? {
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
