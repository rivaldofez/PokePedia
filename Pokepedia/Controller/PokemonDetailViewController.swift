//
//  PokemonDetailViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/02/23.
//

import UIKit
import Charts

class PokemonDetailViewController: UIViewController {

    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "charizard")
        
        return imageView
    }()
    
    private let pokemonHeightLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.5m"
        return label
    }()
    
    private let pokemonNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Charizard"
        return label
    }()
    
    private let pokemonWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10 kg"
        return label
    }()
    
    private let pokemonSpeciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Seed Pokemon"
        return label
    }()
    
    private let pokemonBaseExpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "64"
        return label
    }()
    
    private let pokemonIDLabel: UILabel = {
        let label = UILabel()
        label.text = "999"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let brief: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pokemonBriefLabel: UILabel = {
        let label = UILabel()
        label.text = "Charizard, known in Japan as Lizardon, is a Pokémon in Nintendo and Game Freak's Pokémon franchise. Created by Atsuko Nishida, Charizard first appeared in the video games Pokémon Red and Blue and subsequent sequels."
        return label
    }()
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private var test: [UIButton] = ["Fire", "Flying", "Dragon"].map { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.layer.cornerRadius = 10
        
        var configButton = UIButton.Configuration.plain()
        configButton.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        button.configuration = configButton
        button.clipsToBounds = true
        button.tintColor = .label
        button.backgroundColor = .systemBlue
        return button
    }
    
    private lazy var pokemonTypeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: test)

        stackView.axis = .horizontal
        stackView.spacing = 16
//        stackView.distribution = .equalCentering
//        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var pokemonSizeStackView: UIStackView = {
        let heightLabel = UILabel()
        heightLabel.text = "Height"
        
        let weightLabel = UILabel()
        weightLabel.text = "Weight"
        
        let weightStackView = UIStackView()
        weightStackView.axis = .vertical
        weightStackView.addArrangedSubview(weightLabel)
        weightStackView.addArrangedSubview(pokemonWeightLabel)
        
        let heightStackView = UIStackView()
        heightStackView.axis = .vertical
        heightStackView.addArrangedSubview(heightLabel)
        heightStackView.addArrangedSubview(pokemonHeightLabel)
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(weightStackView)
        stackView.addArrangedSubview(heightStackView)
        stackView.spacing = 10
        return stackView
    }()
    
    
    private var mainScrollView: UIScrollView = {
       let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    
    private lazy var baseStatRadarChart: RadarChartView = {
        let chartView = RadarChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    
    let redDataSet = RadarChartDataSet(
        entries: [
            RadarChartDataEntry(value: 255), //HP
            RadarChartDataEntry(value: 255), //Attack
            RadarChartDataEntry(value: 255), //Defense
            RadarChartDataEntry(value: 255), //Speed
            RadarChartDataEntry(value: 255), //Sp.Defense
            RadarChartDataEntry(value: 255) //Sp.Attack
        ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Charizard"
        navigationController?.navigationBar.tintColor = .label
        
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        configureConstraints()
        
        mainStackView.addArrangedSubview(pokemonImageView)
        mainStackView.addArrangedSubview(pokemonNameLabel)
        mainStackView.addArrangedSubview(pokemonTypeStackView)
        mainStackView.addArrangedSubview(brief)
        mainStackView.addArrangedSubview(pokemonBriefLabel)
        mainStackView.addArrangedSubview(pokemonSizeStackView)
        mainStackView.addArrangedSubview(baseStatRadarChart)
        
        // 2
        let data = RadarChartData(dataSets: [redDataSet])

        // 3
        baseStatRadarChart.data = data
        // 1
        redDataSet.lineWidth = 2

        // 2
        let redColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
        let redFillColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 0.6)
        redDataSet.colors = [redColor]
        redDataSet.fillColor = redFillColor
        redDataSet.drawFilledEnabled = true

        // 3
        redDataSet.valueFormatter = DataSetValueFormatter()


        // 2
        baseStatRadarChart.webLineWidth = 1.5
        baseStatRadarChart.innerWebLineWidth = 1
        baseStatRadarChart.webColor = .lightGray
        baseStatRadarChart.innerWebColor = .lightGray

        // 3
        let xAxis = baseStatRadarChart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        xAxis.labelTextColor = .black
        xAxis.valueFormatter = self
        xAxis.labelCount = 5

        // 4
        let yAxis = baseStatRadarChart.yAxis
//        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 0
        yAxis.drawLabelsEnabled = false
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 200
        yAxis.valueFormatter = YAxisFormatter()

        // 5
        baseStatRadarChart.rotationEnabled = true
        baseStatRadarChart.legend.enabled = false
        

    }

    private func configureConstraints(){
        let mainScrollViewConstraints = [
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let mainStackViewConstraints = [
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor)
        ]
        
        let baseStatRadarChartConstraints = [
            baseStatRadarChart.heightAnchor.constraint(equalToConstant: 350),
            baseStatRadarChart.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ]
        
        let pokemonImageViewConstraints = [
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        
        NSLayoutConstraint.activate(mainScrollViewConstraints)
        NSLayoutConstraint.activate(mainStackViewConstraints)
        NSLayoutConstraint.activate(baseStatRadarChartConstraints)
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        
    }

}

extension PokemonDetailViewController: AxisValueFormatter{
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        let titles = ["HP", "Attack", "Defense", "Speed", "Sp.Def", "Sp.Atk"]
        return "\(titles[Int(value) % titles.count])\n\(self.redDataSet[0].y)"
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

