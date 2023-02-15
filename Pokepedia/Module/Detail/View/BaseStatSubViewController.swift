//
//  BaseStatSubViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit
import Charts

class BaseStatSubViewController: UIViewController {

    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.progressTableView.reloadData()
            }
        }
    }
    
    private let progressTableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(BaseStatTableViewCell.self, forCellReuseIdentifier: BaseStatTableViewCell.identifier)
        tableview.isHidden = true
        return tableview
    }()
    
    private lazy var radarChartView: RadarChartView = {
        let chartView = RadarChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(radarChartView)
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
        
        let radarChartViewConstraints = [
            radarChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            radarChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            radarChartView.topAnchor.constraint(equalTo: view.topAnchor),
            radarChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(progressTableViewConstraints)
        NSLayoutConstraint.activate(radarChartViewConstraints)
    }
}

extension BaseStatSubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon?.baseStat.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BaseStatTableViewCell.identifier, for: indexPath) as? BaseStatTableViewCell else { return UITableViewCell() }
        
        if let baseStat = pokemon?.baseStat[indexPath.row]{
            cell.configure(with: baseStat, type: pokemon!.type.first!)
        }
        
        return cell
    }
    
    
}
