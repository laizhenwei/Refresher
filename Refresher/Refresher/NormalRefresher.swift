//
//  NormalRefresher.swift
//  Refresher
//
//  Created by laizw on 2019/1/25.
//  Copyright © 2019 laizw. All rights reserved.
//

import UIKit

public final class NormalRefresher: UIView, Refresher {
    
    public var refreshHeight: CGFloat = 50
    
    public var refreshAction: (() -> ())?
    
    public var view: UIView {
        return self
    }
    
    public let indicatorView = UIActivityIndicatorView(style: .gray)
    
    public let titleLabel = UILabel()
    
    public var indicatorPadding: CGFloat = 10

    public var titles: [RefreshState: String] = [
        .idle: "Pull to refresh",
        .pulling: "Release to refresh",
        .willRefresh: "Release to refresh",
        .refreshing: "Loading...",
        .noMoreData: "No more data"
    ]
    
    public init(action: (() -> ())?) {
        refreshAction = action
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: refreshHeight))
        
        indicatorView.hidesWhenStopped = false
        titleLabel.textColor = UIColor.lightGray
        
        view.addSubview(indicatorView)
        view.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        indicatorView.frame.origin.x = titleLabel.frame.origin.x - indicatorView.bounds.width - indicatorPadding
        indicatorView.center.y = titleLabel.center.y
    }
}

extension NormalRefresher {
    
    public func update(state: RefreshState) {
        titleLabel.text = titles[state]
        titleLabel.sizeToFit()
    }
    
    public func update(progress: CGFloat) {
        alpha = progress
    }
    
    public func startAnimating() {
        indicatorView.startAnimating()
    }
    
    public func stopAnimating() {
        indicatorView.stopAnimating()
    }
}
