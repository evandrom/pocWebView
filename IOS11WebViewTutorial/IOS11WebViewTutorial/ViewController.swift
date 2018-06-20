//
//  ViewController.swift
//  IOS11WebViewTutorial
//
//  Created by Arthur Knopper on 27/12/2017.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    var webView: WKWebView!
    let userContentController = WKUserContentController()
    
    override func loadView() {
        super.loadView()
        //webView.navigationDelegate = self
        userContentController.add(self, name: "recaptcha")
        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        webView = WKWebView(frame: self.view.bounds, configuration: config)
        view = webView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let dict = message.body as! [String:AnyObject]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(self.webView)
        do {
            guard let filePath = Bundle.main.path(forResource: "test", ofType: "html")
                else {
                    // File Error
                    print ("File reading error")
                    return
            }

            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL.init(string: "http://localhost") //URL(fileURLWithPath: filePath)
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
        
        // 1
//        let url = URL(string: "https://www.userede.com.br/Acesso/Criacao/index.html")!
//        webView.load(URLRequest(url: url))
//
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

