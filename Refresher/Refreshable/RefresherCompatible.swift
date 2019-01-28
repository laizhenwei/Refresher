//
//  Refreshable.swift
//  Refresher
//
//  Created by laizw on 2019/1/22.
//

import UIKit

public protocol RefresherCompatible {
    var scrollView: UIScrollView { get }
    
    var header: Refresher? { set get }
    
    var footer: Refresher? { set get }
}

extension RefresherCompatible {
    
    public func addHeader(_ animator: RefreshAnimatable) {
        let header = BackHeaderRefresher(animator: animator)
    }
    
    public func addFooter(_ animator: RefreshAnimatable) {
        let footer = AutoFooterRefresher(animator: animator)
        let top = scrollView.contentSize.height + scrollView.contentInset.bottom
        footer.frame = CGRect(x: 0, y: top, width: scrollView.bounds.width, height: animator.refreshHeight)
        footer.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth
        ]
        self.footer = footer
        scrollView.addSubview(footer)
    }
}

extension RefresherCompatible {
    
    public var isHeaderRefreshing: Bool {
        return header?.isRefreshing ?? false
    }
    
    public func removeHeader() {
        header?.endRrefreshing()
        header?.removeFromSuperview()
        header = nil
    }
    
    public func beginHeaderRefreshing() {
        header?.beginRefreshing()
    }
    
    public func endHeaderRefreshing() {
        header?.endRrefreshing()
    }
}

extension RefresherCompatible {
    
    public var isFooterRefreshing: Bool {
        return footer?.isRefreshing ?? false
    }
    
    public func removeFooter() {
        footer?.endRrefreshing()
        footer?.removeFromSuperview()
        footer = nil
    }
    
    public func beginFooterRefreshing() {
        footer?.beginRefreshing()
    }
    
    public func endFooterRefreshing() {
        footer?.endRrefreshing(noMoreData: false)
    }
    
    public func endFooterRefreshing(noMoreData: Bool) {
        footer?.endRrefreshing(noMoreData: noMoreData)
    }
}

private var RefreshHeaderKey = 0
private var RefreshFooterKey = 0

extension RefresherCompatible {
    var header: Refresher? {
        nonmutating set {
            if let header = newValue {
                header.frame = CGRect(x: 0, y: -animator.refreshHeight, width: scrollView.bounds.width, height: animator.refreshHeight)
                header.autoresizingMask = [
                    .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth
                ]
                self.header = header
                scrollView.addSubview(header)
            }
            objc_setAssociatedObject(scrollView, &RefreshHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(scrollView, &RefreshHeaderKey) as? Refresher
        }
    }
    
    var footer: Refresher? {
        nonmutating set {
            objc_setAssociatedObject(scrollView, &RefreshFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(scrollView, &RefreshFooterKey) as? Refresher
        }
    }
}

extension UIScrollView {
    public var refresh: RefresherCompatible {
        return RefresherMaker(self)
    }
}

private struct RefresherMaker: RefresherCompatible {
    let scrollView: UIScrollView
    init(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
}
