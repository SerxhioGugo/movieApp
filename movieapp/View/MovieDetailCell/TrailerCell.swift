//
//  TrailerCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/12/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import WebKit

class TrailerCell: UICollectionViewCell {
//    URL(string: "https://www.youtube.com/embed/\(key)")
    var videoSource: Any? {
        didSet {
            guard
                let videos = videoSource as? VideoResult,
                let key = videos.key,
                let keyUrl = URL(string: "https://www.youtube.com/embed/\(key)")
            
                else { return }
            
            let trailerUrl = URLRequest(url: keyUrl)
            self.trailerWebView.load(trailerUrl)
        }
    }
    
    let trailerWebView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.bounces = false
        webView.backgroundColor = .myBlack
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(trailerWebView)
        trailerWebView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
