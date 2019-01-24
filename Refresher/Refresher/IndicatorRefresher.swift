//
//  IndicatorRefresher.swift
//  Refresher
//
//  Created by laizw on 2019/1/24.
//  Copyright © 2019 buzzvideo. All rights reserved.
//

import UIKit

final class IndicatorRefresher: Refresher {
    
    var holderHeight: CGFloat = 50
    
    var refreshAction: (() -> ())?
    
    let indicatorView: UIActivityIndicatorView
    
    init(style: UIActivityIndicatorView.Style, action: (() -> ())?) {
        self.indicatorView = UIActivityIndicatorView(style: style)
        self.refreshAction = action
    }
    
    var view: UIView {
        return indicatorView
    }
    
    func startAnimating() {
        indicatorView.startAnimating()
    }
    
    func stopAnimating() {
        indicatorView.stopAnimating()
    }
}
