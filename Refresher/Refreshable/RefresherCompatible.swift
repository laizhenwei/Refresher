//
//  Refreshable.swift
//  Refresher
//
//  Created by laizw on 2019/1/22.
//

import UIKit

public protocol RefresherCompatible {
    var scrollView: UIScrollView { get }
    var header: (UIView & Refreshable)? { get }
    var footer: (UIView & Refreshable)? { get }
    
    func addHeader(_ refresher: Refresher)
    func addFooter(_ refresher: Refresher)
    
    func removeHeader()
    func removeFooter()
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
    func addHeader(_ refresher: Refresher) {
        let header = HeaderRefresher(refresher: refresher)
        header.frame = CGRect(x: 0, y: -refresher.holderHeight, width: scrollView.bounds.width, height: refresher.holderHeight)
        header.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth
        ]
        scrollView.addSubview(header)
        self.header = header
    }
    
    func addFooter(_ refresher: Refresher) {
        let footer = FooterRefresher(refresher: refresher)
        let top = scrollView.contentSize.height + scrollView.contentInset.bottom
        footer.frame = CGRect(x: 0, y: top, width: scrollView.bounds.width, height: refresher.holderHeight)
        footer.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth
        ]
        scrollView.addSubview(footer)
        self.footer = footer
    }
    
    func removeHeader() {
        header?.endRrefreshing()
        header?.removeFromSuperview()
        header = nil
    }
    
    func removeFooter() {
        footer?.endRrefreshing()
        footer?.removeFromSuperview()
        footer = nil
    }
}

extension RefresherMaker {
    private struct Keys {
        static var Header = 0
        static var Footer = 0
    }
    
    var header: (UIView & Refreshable)? {
        nonmutating set {
            objc_setAssociatedObject(scrollView, &Keys.Header, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(scrollView, &Keys.Header) as? (UIView & Refreshable)
        }
    }
    
    var footer: (UIView & Refreshable)? {
        nonmutating set {
            objc_setAssociatedObject(scrollView, &Keys.Footer, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(scrollView, &Keys.Footer) as? (UIView & Refreshable)
        }
    }
}
