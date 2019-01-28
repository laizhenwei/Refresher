//
//  RefresherViewController.swift
//  Examples
//
//  Created by laizw on 2019/1/25.
//  Copyright © 2019 laizw. All rights reserved.
//

import UIKit
import Refresher

class IndicatorViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.refresh.addHeader(IndicatorRefreshAnimator(style: .gray, action: {
            self.refreshData()
        }))
        
        tableView.refresh.addFooter(IndicatorRefreshAnimator(style: .gray, action: {
            self.fetchMoreData()
        }))
    }
}

class NormalViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refresh.addHeader(NormalRefreshAnimator(action: {
            self.refreshData()
        }))
        
        tableView.refresh.addFooter(NormalRefreshAnimator(action: {
            self.fetchMoreData()
        }))
    }
}
