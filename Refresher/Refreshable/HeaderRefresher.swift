//
//  Refresher.swift
//  Refresher
//
//  Created by laizw on 2019/1/23.
//  Copyright © 2019 buzzvideo. All rights reserved.
//

import UIKit

final class HeaderRefresher: UIView, Refreshable {
    var scrollView: UIScrollView?
    
    var scrollViewInset: UIEdgeInsets = .zero
    
    var state: RefreshState = .idle {
        didSet {
            guard oldValue != state else { return }
            refresher.update(state: state)
        }
    }
    
    let refresher: Refresher
    
    init(refresher: Refresher) {
        self.refresher = refresher
        super.init(frame: .zero)
        refresher.update(state: .idle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        refresherWillMoveToSuperView(newSuperview)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        refresherDidMoveToSuperView()
    }
}

extension HeaderRefresher {
    func scrollView(_ scrollView: UIScrollView, didChangeOffset: NSKeyValueObservedChange<CGPoint>) {
        guard !isRefreshing else { return }
        
        var insetTop = scrollViewInset.top
        if #available(iOS 11.0, *) {
            insetTop += scrollView.safeAreaInsets.top
        }
        let offset = scrollView.contentOffset.y + insetTop
        guard offset <= 0 else { return }
        
        let triggerDistance = -offset
        let distance = bounds.height + refresher.triggerDistance
        let progress = max(0, min(triggerDistance / distance, 1))
        
        if scrollView.isDragging {
            refresher.update(progress: progress)
            if triggerDistance > distance {
                state = .pulling
            } else {
                state = .idle
            }
        } else if state == .pulling {
            beginRefreshing()
        } else if progress < 1 {
            refresher.update(progress: progress)
        }
    }
    
    func scrollView(_ scrollView: UIScrollView, didChangeContentSize: NSKeyValueObservedChange<CGSize>) {
        
    }
    
    func startAnimating(completion: @escaping () -> ()) {
        guard let view = scrollView else { return }
        refresher.startAnimating()
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            guard view.panGestureRecognizer.state != .cancelled else { return }
            var insetTop = self.scrollViewInset.top + self.bounds.height
            view.contentInset.top = insetTop
            if #available(iOS 11.0, *) {
                insetTop += view.safeAreaInsets.top
            }
            let offset = CGPoint(x: view.contentOffset.x, y: -insetTop)
            view.setContentOffset(offset, animated: false)
        }, completion: { _ in
            completion()
        })
    }
    
    func stopAnimating(completion: @escaping () -> ()) {
        guard let view = scrollView else { return }
        refresher.stopAnimating()
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            view.contentInset.top = self.scrollViewInset.top
        }, completion: { _ in
            self.refresher.update(progress: 0)
            completion()
        })
    }
}
