//
//  Refresher.swift
//  Refresher
//
//  Created by laizw on 2019/1/23.
//

import UIKit

public protocol Refresher {
    var view: UIView { get }
    var holderHeight: CGFloat { get }
    var triggerDistance: CGFloat { get }
    
    var refreshAction: (() -> ())? { set get }
    
    func update(state: RefreshState)
    func update(progress: CGFloat)
    
    func startAnimating()
    func stopAnimating()
}

extension Refresher {
    var triggerDistance: CGFloat { return 0 }
    
    func update(state: RefreshState) {}
    func update(progress: CGFloat) {}
}
