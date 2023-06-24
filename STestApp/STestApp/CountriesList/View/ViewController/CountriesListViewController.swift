//
//  CountriesListViewController.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import UIKit
import SnapKit

class CountriesListViewController: UIViewController {
    //MARK: - Properties
    private let sizingCell = CountryCell()
    var coordinator: CountriesListFlow?
    
    private let viewModel: CountriesListViewModel
    
    private lazy var collectionView: UICollectionView = {
        let layout = JumpAvoidingFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = true
        view.allowsMultipleSelection = true
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    //MARK: - Init Methods
    init(viewModel: CountriesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountries()
        configureView()
    }
    
    //MARK: - Methods
    private func configureView() {
        title = "World Countries"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SFProText-Semibold", size: 17)!]
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: Constants.ReuseIdentifiers.countryCell)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.ReuseIdentifiers.headerReusable)
        
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getCountries() {
        viewModel.getCountries {
            self.viewModel.countriesListModel.bind { countries in
                self.viewModel.modifyData()
            }
            self.collectionView.reloadData()
        } failure: { error in
            print(error)
        }
    }
    
    @objc private func learnMoreAction(sender: CellButton) {
        if let cca2Code = sender.cca2Code {
            coordinator?.coordinateToCountry(cca2Code: cca2Code)
        }
        
    }
}

//MARK: - CollectionViewDataSource
extension CountriesListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifiers.countryCell, for: indexPath) as! CountryCell
        cell.country = viewModel.sortedCountries[indexPath.section][indexPath.item]
        let cca2Code = viewModel.sortedCountries[indexPath.section][indexPath.item].cca2Code
        cell.learnMoreButton.cca2Code = cca2Code
        cell.learnMoreButton.addTarget(self, action: #selector(learnMoreAction), for: .touchUpInside)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.viewModel.sortedContinents.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.sortedCountries[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.ReuseIdentifiers.headerReusable, for: indexPath) as! HeaderCollectionReusableView
            headerView.sectionTitle.text = viewModel.sortedContinents[indexPath.section].uppercased()
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

//MARK: - CollectionViewFlowLayout
extension CountriesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        
        sizingCell.frame = CGRect(
            origin: .zero,
            size: CGSize(width: collectionView.bounds.width - 32, height: 312)
        )
        
        sizingCell.isSelected = isSelected
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        
        let size = sizingCell.systemLayoutSizeFitting(
            CGSize(width: collectionView.bounds.width - 32, height: .greatestFiniteMagnitude),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
        
        return size
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 12, left: 16, bottom: 24, right: 16)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 18)
    }
}

//MARK: - CollectionViewDelegate
extension CountriesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        return true
    }
}
