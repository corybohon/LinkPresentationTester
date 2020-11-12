//
//  ViewController.swift
//  LPTester
//
//  Created by Cory Bohon on 11/11/20.
//

import UIKit
import LinkPresentation

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView! 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStaticMetaData()
        loadVideoMetadata()
    }

    func loadStaticMetaData() {
        let url = URL(string: "http://apple.com/iphone")!
        loadMetadata(for: url)
    }
    
    func loadVideoMetadata() {
        let url = URL(string: "https://p-events-delivery.akamaized.net/2010ayctcrodak763xivpxn4htcuhco9/m3u8/vod_index-2MxnV7vcNFJoAHxqBcV9CU3w3JsXVVgh.m3u8")!
        loadMetadata(for: url)
    }
    
    func loadMetadata(for url: URL) {
        let metadataProvider = LPMetadataProvider()
        metadataProvider.startFetchingMetadata(for: url) { (returnedMetadata, error) in
            if let metadata = returnedMetadata, error == nil {
                print("Title: " + (metadata.title ?? "No Title"))
                
                DispatchQueue.main.async { [weak self] in
                    self?.addLinkView(metadata: metadata)
                }
            }
        }
    }
    
    func addLinkView(metadata: LPLinkMetadata) {
        let linkView = LPLinkView(metadata: metadata)
        linkView.bounds = CGRect(x: 0, y: 0, width: 200.0, height: 150.0)
        stackView.addArrangedSubview(linkView)
    }
}

