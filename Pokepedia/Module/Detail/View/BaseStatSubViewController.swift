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
                self.setDataRadarChartView()
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
        chartView.webLineWidth = 1
        chartView.webColor = .lightGray
        chartView.innerWebColor = .green
        
        return chartView
        
    }()
    
    private func setDataRadarChartView(){
        guard let pokemon = self.pokemon else { return }
        var entries : [RadarChartDataEntry] = []
        
        pokemon.baseStat.forEach { stat in
            entries.append(RadarChartDataEntry(value: Double(stat.value)))
        }
        
        let dataset = RadarChartDataSet(entries: entries)
        dataset.colors = [.red]
        dataset.fillColor = .blue
        dataset.drawFilledEnabled = true
        
        radarChartView.data = RadarChartData(dataSets: [dataset])
        
        dataset.valueFormatter = DataSetValueFormatter()
        
        let xAxis = radarChartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .bold)
        xAxis.labelTextColor = .black
        xAxis.valueFormatter = self
        xAxis.labelCount = 5
        
        let yAxis = radarChartView.yAxis
        yAxis.labelCount = 0
        yAxis.drawLabelsEnabled = false
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 255
//        YAxisFormatter = self
//        yAxis.valueFormatter = YAxisFormatter()
        yAxis.valueFormatter = self
        
        radarChartView.rotationEnabled = true
//        radarChartView.legend.enabled = true

    }
    
    
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

extension BaseStatSubViewController: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let pokemon = pokemon else { return "" }
        
        let titles = pokemon.baseStat.map { stat in
            return PokemonConverter.typeStringToStatName(type: stat.name)
        }
        
        return "\(titles[Int(value) % titles.count])"
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


class DataSetValueFormatter: ValueFormatter {

    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}

// 2
class XAxisFormatter: AxisValueFormatter {

    let titles = ["HP", "Attack", "Defense", "Speed", "Sp.Def", "Sp.Atk"]

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
        return titles[Int(value) % titles.count]
    }
}

// 3
class YAxisFormatter: AxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
        return "\(Int(value)) $"
    }
}
