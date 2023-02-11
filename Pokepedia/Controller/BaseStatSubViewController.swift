//
//  BaseStatSubViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

class BaseStatSubViewController: UIViewController {

    private let progressBar: UIProgressView = {
       let progressview = UIProgressView()
        progressview.translatesAutoresizingMaskIntoConstraints = false
        return progressview
    }()
    
    private let progressTableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(BaseStatTableViewCell.self, forCellReuseIdentifier: BaseStatTableViewCell.identifier)
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(progressBar)
        view.addSubview(progressTableView)
        configureConstraints()
        
        progressTableView.dataSource = self
        progressTableView.delegate = self
        
        
//        let progressBarConstraints = [
//            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            progressBar.heightAnchor.constraint(equalToConstant: 10)
//        ]
//
//        NSLayoutConstraint.activate(progressBarConstraints)
//
//        progressBar.setProgress(0.5, animated: true)
//        progressBar.trackTintColor = .lightGray
//        progressBar.tintColor = .blue
        
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
