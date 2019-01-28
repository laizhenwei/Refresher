//
//  EntryViewController.swift
//  Examples
//
//  Created by laizw on 2019/1/25.
//  Copyright © 2019 laizw. All rights reserved.
//

import UIKit

class EntryViewController: UITableViewController {
    
    struct Style {
        let name: String
        let type: UIViewController.Type
    }
    
    let styles: [Style] = [
        Style(name: "normal", type: NormalViewController.self),
        Style(name: "indicator", type: IndicatorViewController.self),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = styles[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = styles[indexPath.row].type.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}
