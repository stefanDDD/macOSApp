//
//  MainViewController.swift
//  BreakingBad
//
//  Created by stefan on 31.03.2025.
//

import Foundation
import UIKit
import WebKit

class MainViewController: UIViewController{
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var uiViewData: WKWebView!

    @IBAction func charactersButtonTapped(_ sender: UIButton) {
    }
    @IBAction func uploadButtonTapped(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewbg)
        self.view.sendSubviewToBack(imageViewbg)
        if let url = URL(string: "https://www.youtube.com/@breakingbad") {
            let request = URLRequest(url: url)
            uiViewData.load(request)
        }
        styleBreakingBadWebView(webView: self.uiViewData)
        styleBreakingBadButton(button: self.charactersButton)
        styleBreakingBadButton(button: self.uploadButton)
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

    func styleBreakingBadWebView(webView: WKWebView) {
        webView.layer.cornerRadius = 15
        webView.clipsToBounds = true
        webView.layer.borderWidth = 3
        webView.layer.borderColor = UIColor.green.cgColor
        webView.layer.shadowColor = UIColor.black.cgColor
        webView.layer.shadowOffset = CGSize(width: 0, height: 4)
        webView.layer.shadowOpacity = 0.7
        webView.layer.shadowRadius = 6
        webView.backgroundColor = UIColor(red: 20/255, green: 40/255, blue: 20/255, alpha: 1)
        webView.isOpaque = false
    }


}
