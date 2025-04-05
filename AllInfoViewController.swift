//
//  AllInfoViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation
import UIKit

import UIKit

class AllInfoViewController: UIViewController {

    var characterData: Character?

    // MARK: - outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var urlViewButtonStyle: UIButton!
    @IBOutlet weak var uiViewLayout: UIView!
    @IBOutlet weak var nameLabelDescr: UILabel!
    @IBOutlet weak var aliasLabelDescr: UILabel!
    @IBOutlet weak var actorLabelDescr: UILabel!
    @IBOutlet weak var roleLabelDescr: UILabel!
    @IBOutlet weak var quoteLabelDescr: UILabel!
    @IBOutlet weak var urlLabelDescr: UILabel!

    // MARK: - actions
    @IBAction func urlViewButton(_ sender: UIButton) {
        // Add your URL view action logic here
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewbg)
        self.view.sendSubviewToBack(imageViewbg)

        styleBreakingBadButton(button: self.urlViewButtonStyle)
        styleImageView(imgView: self.imageView)
        styleDescrLabel(label: nameLabelDescr)
        styleDescrLabel(label: aliasLabelDescr)
        styleDescrLabel(label: actorLabelDescr)
        styleDescrLabel(label: roleLabelDescr)
        styleDescrLabel(label: quoteLabelDescr)
        styleDescrLabel(label: urlLabelDescr)

        styleNameLabel(label: self.nameLabel, data: characterData!.name)
        styleNameLabel(label: self.aliasLabel, data: characterData!.alias)
        styleNameLabel(label: self.actorLabel, data: characterData!.actor)
        styleNameLabel(label: self.roleLabel, data: characterData!.role)
        styleNameLabel(label: self.quoteLabel, data: characterData!.quote)
        styleNameLabel(label: self.urlLabel, data: characterData!.url)
        styleUIViewLayout(uiView: self.uiViewLayout)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sequeDisplayURL" {
            if let destController = segue.destination as? UrlViewController {
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
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 4
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(white: 0.2, alpha: 0.5)

        label.layoutMargins = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }

    func styleUIViewLayout(uiView: UIView) {
        uiView.backgroundColor = UIColor(white: 1.0, alpha: 0.6)
        uiView.layer.cornerRadius = 15
        uiView.layer.masksToBounds = true
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowOpacity = 0.7
        uiView.layer.shadowRadius = 4
    }

    func styleDescrLabel(label: UILabel) {
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 4
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(white: 0.4, alpha: 0.7)
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
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
