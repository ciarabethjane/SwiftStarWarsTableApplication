//
//  WebViewController.swift
//  CiaraElizabethGriffin
//
//  Created by Ciara-Beth  on 09/03/2022.
//
// Import Foundation, WebKit and UIKit libraries
import Foundation
import WebKit
import UIKit

// Create a class called WebViewController
class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate{
    
    // activityIndicator Outlet (to be used to indicate that the webpage is being loaded)
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // loadingView outlet (This view contains the activity indicator)
    @IBOutlet weak var loadingView: UIView! {
      didSet {
        loadingView.layer.cornerRadius = 6
      }
    }
    // WebView outlet
    @IBOutlet var webView:WKWebView!
   
    // Model Data
    var characterData: Character!
    
    
    
    override func viewDidLoad() {
        showSpinner()
        super.viewDidLoad()
        // set personurl to contain the weblink belonging to the relevant character
        let characterurl = characterData.weblink
        webView.navigationDelegate = self
        webView.uiDelegate = self
        // set theurl to create a URL from the string contained in personurl
        let theurl = URL(string: characterurl)!
        // have the webView load the url contained in theurl variable
        webView.load(URLRequest(url: theurl))
        
        webView.allowsBackForwardNavigationGestures = true
    }
    // Use this function to display the loadingView and animate the activityIndicator
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }
}

    extension WebViewController {
        func webView(_ webView: WKWebView, didCommit: WKNavigation!){
            activityIndicator.stopAnimating()
            loadingView.isHidden = true
        }
       
    }
    // Use this function to hide the loadingView and stop animating the activityIndicator
    
   
    



