//
//  ViewController.swift
//  HealthKitQuickFamiliarizationTest
//
//  Created by Glenn Posadas on 10/18/20.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .grouped)
    let items = [
        "aaaaa",
        "bbbbb",
        "ccccc"
    ]
    
    let headers = [
        "A",
        "B\n2liner",
        "C..."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = self.headers[section]
        return header
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "cell") }
        
        cell?.textLabel?.text = self.items[indexPath.section]
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
}

