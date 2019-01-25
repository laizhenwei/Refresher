//
//  ViewController.swift
//  Examples
//
//  Created by laizw on 2019/1/25.
//  Copyright © 2019 laizw. All rights reserved.
//

import UIKit
import Refresher

class ViewController: UIViewController {
    
    var items = [Int](0...10)
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.dataSource = self
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

extension ViewController {
    func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.items = [Int](0...10)
            self.tableView.reloadData()
            self.tableView.refresh.endHeaderRefreshing()
        }
    }
    
    func fetchMoreData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.items.append(contentsOf: [Int](0...10))
            self.tableView.reloadData()
            self.tableView.refresh.endFooterRefreshing()
        }
    }
}
