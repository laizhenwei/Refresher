//
//  NormalRefresher.swift
//  Refresher
//
//  Created by laizw on 2019/1/25.
//  Copyright © 2019 laizw. All rights reserved.
//

import UIKit

public final class NormalRefresher: Refresher {
    
    public var refreshHeight: CGFloat = 50
    
    public var refreshAction: (() -> ())?
    
    public let view = UIView()
    
    public let indicatorView = UIActivityIndicatorView(style: .gray)
    
    public let titleLabel = UILabel()
    
    public var indicatorPadding: CGFloat = 15

    public var titles: [RefreshState: String] = [
        .idle: "Pull to refresh",
        .pulling: "Release to refresh",
        .willRefresh: "Release to refresh",
        .refreshing: "Loading...",
        .noMoreData: "No more data"
    ]
    
    public init(action: (() -> ())?) {
        refreshAction = action
        indicatorView.hidesWhenStopped = false
        titleLabel.textColor = UIColor.lightGray
        
        view.addSubview(indicatorView)
        view.addSubview(titleLabel)
    }
}

extension NormalRefresher {
    
    public func update(state: RefreshState) {
        titleLabel.text = titles[state]
        titleLabel.sizeToFit()
        
        titleLabel.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        indicatorView.frame.origin.x = titleLabel.frame.origin.x - indicatorView.bounds.width - indicatorPadding
        indicatorView.center.y = titleLabel.center.y
    }
    
    public func startAnimating() {
        indicatorView.startAnimating()
    }
    
    public func stopAnimating() {
        indicatorView.stopAnimating()
    }
}
