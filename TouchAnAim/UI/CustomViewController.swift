//
//  CustomViewController.swift
//  TouchAnAim
//
//  Created by Petro on 18.10.2021.
//

import UIKit
import WebKit

class CustomViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var URL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: self.URL!)
        self.webView.load(myRequest)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
}
