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

        tableView.refresh.addHeader(IndicatorRefresher(style: .gray, action: {
            self.refreshData()
        }))
        
        tableView.refresh.addFooter(IndicatorRefresher(style: .gray, action: {
            self.fetchMoreData()
        }))
    }
}

class NormalViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refresh.addHeader(NormalRefresher(action: {
            self.refreshData()
        }))
        
        tableView.refresh.addFooter(NormalRefresher(action: {
            self.fetchMoreData()
        }))
    }
}
