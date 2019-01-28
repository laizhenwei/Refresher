//
//  RefreshAnimatable.swift
//  Refresher
//
//  Created by laizw on 2019/1/23.
//

import UIKit

public protocol RefreshAnimatable {
    var view: UIView { get }
    
    var refreshHeight: CGFloat { get }
    var triggerDistance: CGFloat { get }
    
    var refreshAction: (() -> ())? { set get }
    
    func update(state: RefreshState)
    func update(progress: CGFloat)
    
    func startAnimating()
    func stopAnimating()
}

extension RefreshAnimatable {
    public var triggerDistance: CGFloat {
        return 0
    }
}
