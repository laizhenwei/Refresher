//
//  IndicatorRefresher.swift
//  Refresher
//
//  Created by laizw on 2019/1/24.
//  Copyright © 2019 buzzvideo. All rights reserved.
//

import UIKit

public final class IndicatorRefresher: Refresher {
    
    public var refreshHeight: CGFloat = 50
    
    public var refreshAction: (() -> ())?
    
    public let indicatorView: UIActivityIndicatorView
    
    public init(style: UIActivityIndicatorView.Style, action: (() -> ())?) {
        self.indicatorView = UIActivityIndicatorView(style: style)
        self.indicatorView.hidesWhenStopped = false
        self.refreshAction = action
    }
    
    public var view: UIView {
        return indicatorView
    }
    
    public func update(progress: CGFloat) {
        indicatorView.alpha = abs(progress)
    }
    
    public func startAnimating() {
        indicatorView.startAnimating()
    }
    
    public func stopAnimating() {
        indicatorView.stopAnimating()
    }
}
