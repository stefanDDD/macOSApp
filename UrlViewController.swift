//
//  UrlViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import Foundation
import UIKit
import WebKit

class UrlViewController: UIViewController {
    var characterData: Character?
    @IBOutlet weak var urlWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewbg)
        self.view.sendSubviewToBack(imageViewbg)
        if let urlString = characterData?.url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            urlWebView.load(request)
        }
    }
}

