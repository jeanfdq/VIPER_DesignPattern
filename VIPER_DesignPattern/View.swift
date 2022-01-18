//
//  View.swift
//  VIPER_DesignPattern
//
//  Created by Jean Paul Borges Manzini on 18/01/22.
//

// ViewController
// Protocol
// Ref to Presenter

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    
    var users = [User]()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(label)
        
        view.addSubview(tableView)
        tableView.delegate      = self
        tableView.dataSource    = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
        label.center = view.center
        label.frame = view.bounds
    }
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
        
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.tableView.isHidden = true
            self.label.isHidden     = false
            self.label.text = error
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
}
