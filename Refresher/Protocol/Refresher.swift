//
//  Refresher.swift
//  Refresher
//
//  Created by laizw on 2019/1/23.
//

import UIKit

public enum RefreshState {
    case idle, pulling, willRefresh, refreshing, noMoreData
}

public protocol Refresher {
    var view: UIView { get }
    
    var refreshHeight: CGFloat { get }
    var triggerDistance: CGFloat { get }
    
    var refreshAction: (() -> ())? { set get }
    
    func update(state: RefreshState)
    func update(progress: CGFloat)
    
    func startAnimating()
    func stopAnimating()
}

extension Refresher {
    public var triggerDistance: CGFloat { return 0 }
    
    public func update(state: RefreshState) {}
    public func update(progress: CGFloat) {}
}
