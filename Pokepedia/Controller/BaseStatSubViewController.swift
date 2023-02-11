//
//  BaseStatSubViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

class BaseStatSubViewController: UIViewController {
    
    private let progressTableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(BaseStatTableViewCell.self, forCellReuseIdentifier: BaseStatTableViewCell.identifier)
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(progressTableView)
        configureConstraints()
        
        progressTableView.dataSource = self
        progressTableView.delegate = self
        
    }
    
    private func configureConstraints(){
        let progressTableViewConstraints = [
            progressTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressTableView.topAnchor.constraint(equalTo: view.topAnchor),
            progressTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(progressTableViewConstraints)
    }
}

extension BaseStatSubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseStatTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    
}
