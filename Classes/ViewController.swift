//
//  ViewController.swift
//  Refresher
//
//  Created by laizw on 2019/1/23.
//  Copyright © 2019 buzzvideo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [Int](0...10)
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
//        tableView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height - 200)
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.refresh.addHeader(IndicatorRefresher(style: .gray, action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.items = [Int](0...10)
                self.tableView.refresh.header?.endRrefreshing()
                self.tableView.reloadData()
            })
        }))
        
        tableView.refresh.addFooter(IndicatorRefresher(style: .gray, action: {
            let count = self.items.count
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.items.append(contentsOf: [Int](count...count + 10))
                self.tableView.refresh.footer?.endRrefreshing()
                self.tableView.reloadData()
            })
        }))
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

