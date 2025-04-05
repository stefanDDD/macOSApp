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
        styleBreakingBadWebView(webView: self.urlWebView)
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

