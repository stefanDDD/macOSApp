//
//  MainViewController.swift
//  BreakingBad
//
//  Created by stefan on 31.03.2025.
//

import Foundation
import UIKit

class MainViewController: UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewbg)
        self.view.sendSubviewToBack(imageViewbg)
    }
    
}
