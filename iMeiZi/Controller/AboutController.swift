//
//  AboutController.swift
//  iMeiZi
//
//  Created by kingcos on 13/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit
import WebKit

class AboutController: UIViewController {
    
    let blogWebsite = "http://www.jianshu.com/u/b88081164fe8"
    
    var webView: WKWebView!
    var loadingProgressView: UIProgressView!

    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
    }
}

// MARK: UI related
extension AboutController {
    fileprivate func setupUI() {
        addWebView()
        addProgressView()
        
        view.bringSubview(toFront: panelView)
    }
    
    private func addWebView() {
        webView = WKWebView(frame: view.frame)
        
        guard let url = URL(string: blogWebsite) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
        webView.addObserver(self,
                              forKeyPath: #keyPath(WKWebView.estimatedProgress),
                              options: .new,
                              context: nil)
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.title),
                            options: .new,
                            context: nil)
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.canGoBack),
                            options: .new,
                            context: nil)
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.canGoForward),
                            options: .new,
                            context: nil)
        
        view.addSubview(webView)
    }
    
    private func addProgressView() {
        loadingProgressView = UIProgressView(frame: CGRect(x: 0.0, y: 64.0,
                                                           width: view.frame.width,
                                                           height: 2.0))
    
        view.addSubview(loadingProgressView)
    }
}

// MARK: Button actions
extension AboutController {
    @IBAction func backButtonClick(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonClick(_ sender: UIButton) {
        webView.goForward()
    }
    
    @IBAction func refreshButtonClick(_ sender: UIButton) {
        if webView.estimatedProgress == 1.0 {
            webView.reload()
        } else {
            webView.stopLoading()
        }
    }
    
    @IBAction func shareButtonClick(_ sender: UIButton) {
        guard let url = webView.url else { return }
        let activityController = UIActivityViewController(activityItems: [url],
                                                          applicationActivities: nil)
        present(activityController, animated: true)
    }
}

extension AboutController {
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let webView = object as? WKWebView {
            if keyPath == #keyPath(WKWebView.estimatedProgress) {
                loadingProgressView.progress = Float(webView.estimatedProgress)
                loadingProgressView.isHidden = (webView.estimatedProgress == 1.0)
                
                if webView.estimatedProgress == 1.0 {
                    refreshButton.setImage(#imageLiteral(resourceName: "about_refresh"), for: .normal)
                } else {
                    refreshButton.setImage(#imageLiteral(resourceName: "about_stop"), for: .normal)
                }
            } else if keyPath == #keyPath(WKWebView.title) {
                guard let webViewTitle = webView.title else { return }
                title = webViewTitle
            } else if keyPath == #keyPath(WKWebView.canGoBack) {
                backButton.isEnabled = webView.canGoBack
            } else if keyPath == #keyPath(WKWebView.canGoForward) {
                forwardButton.isEnabled = webView.canGoForward
            }
        }
    }
}
