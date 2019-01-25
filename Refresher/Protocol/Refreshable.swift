//
//  Refreshable.swift
//  Refresher
//
//  Created by laizw on 2019/1/22.
//

import UIKit

public protocol Refreshable: class {
    
    var scrollView: UIScrollView? { set get }
    
    var scrollViewInset: UIEdgeInsets { set get }
    
    var state: RefreshState { set get }
    
    var refresher: Refresher { get }
    
    func scrollView(_ scrollView: UIScrollView, didChangeOffset: NSKeyValueObservedChange<CGPoint>)
    func scrollView(_ scrollView: UIScrollView, didChangeContentSize: NSKeyValueObservedChange<CGSize>)
    
    func startAnimating(completion: @escaping () -> ())
    
    func stopAnimating(completion:  @escaping () -> ())
}

extension Refreshable {
    public var isRefreshing: Bool {
        return state == .refreshing || state == .willRefresh
    }
}

extension Refreshable where Self: UIView {
    public func refresherWillMoveToSuperView(_ view: UIView?) {
        removeObserver()
        if let view = view as? UIScrollView {
            scrollViewInset = view.contentInset
            DispatchQueue.main.async { [weak self, weak view] in
                self?.observe(scrollView: view)
            }
        }
    }

    public func refresherDidMoveToSuperView() {
        scrollView = superview as? UIScrollView
        if refresher.view.superview == nil {
            addSubview(refresher.view)
            refresher.view.frame = bounds
            refresher.view.autoresizingMask = [
                .flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight
            ]
        }
    }
    
    public func beginRefreshing() {
        guard !isRefreshing else { return }
        if window != nil {
            state = .refreshing
            startAnimating(completion: { [weak self] in
                self?.refresher.refreshAction?()
            })
        } else {
            state = .willRefresh
            DispatchQueue.main.async { [weak self] in
                self?.scrollViewInset = self?.scrollView?.contentInset ?? .zero
                if self?.state == .willRefresh {
                    self?.state = .refreshing
                    self?.startAnimating(completion: {
                        self?.refresher.refreshAction?()
                    })
                }
            }
        }
    }
    
    public func endRrefreshing(noMoreData: Bool = false) {
        stopAnimating(completion: { [weak self] in
            if noMoreData {
                self?.state = .noMoreData
            } else {
                self?.state = .idle
            }
        })
    }
}

private var ObserversKey = 0
extension Refreshable where Self: UIView {
    private var observers: [NSKeyValueObservation] {
        set {
            objc_setAssociatedObject(self, &ObserversKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let val = objc_getAssociatedObject(self, &ObserversKey) as? [NSKeyValueObservation] {
                return val
            }
            return []
        }
    }
    
    private func observe(scrollView: UIScrollView?) {
        guard let view = scrollView else { return }
        let offset = view.observe(\.contentOffset, changeHandler: { [weak self] (view, change) in
            guard !view.isHidden, view.isUserInteractionEnabled else { return }
            self?.scrollView(view, didChangeOffset: change)
        })
        
        let size = view.observe(\.contentSize, changeHandler: { [weak self] (view, change) in
            guard !view.isHidden, view.isUserInteractionEnabled else { return }
            self?.scrollView(view, didChangeContentSize: change)
        })
        
        observers.append(offset)
        observers.append(size)
    }
    
    private func removeObserver() {
        observers.removeAll()
    }
}
