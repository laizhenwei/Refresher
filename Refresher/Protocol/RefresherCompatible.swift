//
//  Refreshable.swift
//  Refresher
//
//  Created by laizw on 2019/1/22.
//

import UIKit

public protocol RefresherCompatible {
    var scrollView: UIScrollView { get }
    var header: Refresher? { get }
    var footer: Refresher? { get }
    
    var isHeaderRefreshing: Bool { get }
    var isFooterRefreshing: Bool { get }
    
    func addHeader(_ refresher: Refresher)
    func addFooter(_ refresher: Refresher)
    
    func removeHeader()
    func removeFooter()
    
    func beginHeaderRefreshing()
    func beginFooterRefreshing()
    
    func endHeaderRefreshing()
    func endFooterRefreshing()
    func endFooterRefreshing(noMoreData: Bool)
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

extension RefresherMaker {
    
    var header: Refresher? {
        return headerRefresher?.refresher
    }
    
    func addHeader(_ refresher: Refresher) {
        let header = HeaderRefresher(refresher: refresher)
        header.frame = CGRect(x: 0, y: -refresher.refreshHeight, width: scrollView.bounds.width, height: refresher.refreshHeight)
        header.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth
        ]
        scrollView.addSubview(header)
        self.headerRefresher = header
    }
    
    func removeHeader() {
        headerRefresher?.endRrefreshing()
        headerRefresher?.removeFromSuperview()
        headerRefresher = nil
    }
    
    var isHeaderRefreshing: Bool {
        return headerRefresher?.isRefreshing ?? false
    }
    
    func beginHeaderRefreshing() {
        headerRefresher?.beginRefreshing()
    }
    
    func endHeaderRefreshing() {
        headerRefresher?.endRrefreshing()
    }
}

extension RefresherMaker {
    var footer: Refresher? {
        return footerRefresher?.refresher
    }
    
    func addFooter(_ refresher: Refresher) {
        let footer = FooterRefresher(refresher: refresher)
        let top = scrollView.contentSize.height + scrollView.contentInset.bottom
        footer.frame = CGRect(x: 0, y: top, width: scrollView.bounds.width, height: refresher.refreshHeight)
        footer.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth
        ]
        scrollView.addSubview(footer)
        self.footerRefresher = footer
    }
    
    func removeFooter() {
        footerRefresher?.endRrefreshing()
        footerRefresher?.removeFromSuperview()
        footerRefresher = nil
    }
    
    var isFooterRefreshing: Bool {
        return footerRefresher?.isRefreshing ?? false
    }
    
    func beginFooterRefreshing() {
        footerRefresher?.beginRefreshing()
    }
    
    func endFooterRefreshing() {
        footerRefresher?.endRrefreshing(noMoreData: false)
    }
    
    func endFooterRefreshing(noMoreData: Bool) {
        footerRefresher?.endRrefreshing(noMoreData: noMoreData)
    }
}

extension RefresherMaker {
    private struct Keys {
        static var Header = 0
        static var Footer = 0
    }
    
    private var headerRefresher: (UIView & Refreshable)? {
        nonmutating set {
            objc_setAssociatedObject(scrollView, &Keys.Header, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(scrollView, &Keys.Header) as? (UIView & Refreshable)
        }
    }
    
    private var footerRefresher: (UIView & Refreshable)? {
        nonmutating set {
            objc_setAssociatedObject(scrollView, &Keys.Footer, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(scrollView, &Keys.Footer) as? (UIView & Refreshable)
        }
    }
}
