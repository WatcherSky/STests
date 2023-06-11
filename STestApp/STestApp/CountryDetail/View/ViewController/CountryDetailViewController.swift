//
//  CountryDetailViewController.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import UIKit
import Kingfisher
import SnapKit

class CountryDetailViewController: UIViewController {
    //MARK: - Properties
    var coordinator: CountryDetailFlow?
    
    private let bullet = "•"
    
    private let viewModel: CountryDetailViewModel

    var country: CountryDetailModel? {
        didSet {
            if let country = country {
                title = country.name.common
                flagImage.kf.setImage(with: country.flags.png)
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1).cgColor
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .white
        return imageView
    }()
    
    //MARK: - Init Methods
    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getCountry()
        configureView()
    }
    
    
    //MARK: - Methods
    private func getCountry() {
        viewModel.getCountry(code: viewModel.cca2Code) {
            self.viewModel.getData()
            self.country = self.viewModel.countryData.first
            self.viewModel.transformCurrensies()
    
            self.tableView.reloadData()
            self.tableView.isHidden = false
        } failure: { error in
            self.tableView.isHidden = false
            print(error)
        }
    }
    
    private func configureView() {
        tableView.register(CountryDetailTableViewCell.self, forCellReuseIdentifier: Constants.ReuseIdentifiers.detailCell)
        makeConstraints()
    }
    
    
    private func makeConstraints() {

        [flagImage, tableView].forEach {
            view.addSubview($0)
        }
        
        flagImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.width.equalTo(view.bounds.width - 32)
            make.height.equalTo(193)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(flagImage.snp.bottom).offset(20)
            make.left.bottom.right.equalTo(view.safeAreaLayoutGuide)

        }
    }
}


extension CountryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifiers.detailCell) as! CountryDetailTableViewCell
        cell.configureView()
        cell.countryPropertyLabel.text = viewModel.dataProperties[indexPath.row]
        switch CellType(rawValue: indexPath.row) {
        case .region:
            let region = viewModel.countryData.first?.subregion
            cell.countryDataLabel.text = region ?? "No Data"
        case .countryName:
            let name = viewModel.countryData.first?.name.common
            cell.countryDataLabel.text = name ?? "No data"
            break
        case .capital:
            let capital = viewModel.countryData.first?.capital
            if capital == nil {
                cell.countryDataLabel.text = "No Data"
            } else {
                let joined = capital?.joined(separator: ", \r\n")
                cell.countryDataLabel.text = joined
            }
            break
        case .capitalCoordinates:
            guard let capitalCoordinates = viewModel.countryData.first?.capitalInfo?.latlng else {
                cell.countryDataLabel.text = "No Data"
                break
            }
            cell.countryDataLabel.text = "\(capitalCoordinates[0]), \(capitalCoordinates[1])"
        case .population:
            let population = viewModel.countryData.first?.population
            if let population = population {
                cell.countryDataLabel.text = "\(population) people "
            } else {
                cell.countryDataLabel.text = "No data"
            }
        case .area:
            let area = viewModel.countryData.first?.area
            if let area = area {
                cell.countryDataLabel.text = "\(area)" + " " + "km²"
            } else {
                cell.countryDataLabel.text = "No data"
            }
        case .currencies:
            if !viewModel.currencyList.isEmpty {
                let currency = viewModel.currencyList
                let joined = currency.joined(separator: ", \r\n")
                cell.countryDataLabel.text = joined
            } else {
                cell.countryDataLabel.text = "No Data"
            }
            break
        case .timezones:
            guard let timezones = viewModel.countryData.first?.timezones else { break }
            let joined = timezones.joined(separator: ", \r\n")
            cell.countryDataLabel.text = joined
        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            guard let capital = country?.capital?.count else { return 54 }
            return 26 + 28 * CGFloat(capital)
        case 6:
            guard let currencies = country?.currencies?.values.count else { return 54 }
            return 26 + 28 * CGFloat(currencies)
        case 7:
            guard let timezones = country?.timezones.count else { return 54 }
            return 26 + 28 * CGFloat(timezones)
        default:
            return 54
        }
    }
}
