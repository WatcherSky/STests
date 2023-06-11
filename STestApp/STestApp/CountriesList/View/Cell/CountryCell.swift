//
//  CountryCell.swift
//  STestApp
//
//  Created by Владимир on 15.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class CountryCell: UICollectionViewCell {
    //MARK: - Properties
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    var country: CountriesListModel? {
        didSet{
            if let country = country {
                DispatchQueue.main.async {
                    self.flagImage.kf.setImage(with: country.flags.png)
                    self.countryNameLabel.text = "\(country.name.common)"
                    self.capitalNameLabel.text = "\(country.capital?.first ?? "")"
                    self.setMultiColorLabel(populationText: "Population: \(country.population) people",
                                            currenciesText: "Currencies: \(country.currencies?.values.first?.name ?? "No Currencies")" + " " +  "\(country.currencies?.values.first?.symbol ?? "")")
                }
            }
        }
    }
    
    private var collapsedConstraint: Constraint!
    private var expandedConstraint: Constraint!
    
    private lazy var mainContainer = UIView()
    private lazy var topContainer = UIView()
    private lazy var bottomContainer = UIView()
    
    private lazy var topStackView: UIStackView = {
        $0.alignment = .leading
        $0.spacing = 4
        $0.axis = .vertical
        return $0
    }(UIStackView(arrangedSubviews: [countryNameLabel, capitalNameLabel]))
    
    private lazy var bottomStackView: UIStackView = {
        $0.alignment = .leading
        $0.spacing = 8
        $0.axis = .vertical
        return $0
    }(UIStackView(arrangedSubviews: [populationLabel, currenciesLabel]))
    
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow_down")!.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    private lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "SFProText-Semibold", size: 17)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var capitalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        return label
    }()
    
    private lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var currenciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    lazy var learnMoreButton: CellButton = {
        let button = CellButton()
        button.setTitle("Learn More", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0.478, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        return button
    }()
    
    //MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    //MARK: - Methods
    
    private func updateAppearance() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * -0.999 )
            self.arrowImageView.transform = self.isSelected ? upsideDown : .identity
        }
    }
    
    private func setMultiColorLabel(populationText: String, currenciesText: String) {
        let mutablePopulationString = NSMutableAttributedString(string: populationText as String, attributes: [NSAttributedString.Key.font :UIFont(name: "SFProText-Regular", size: 15)!])
        mutablePopulationString.addAttribute(NSAttributedString.Key.foregroundColor, value:  UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1), range: NSRange(location: 0,length: 10))
        populationLabel.attributedText = mutablePopulationString
        
        let mutableCurrenciesString = NSMutableAttributedString(string: currenciesText as String, attributes: [NSAttributedString.Key.font :UIFont(name: "SFProText-Regular", size: 15)!])
        mutableCurrenciesString.addAttribute(NSAttributedString.Key.foregroundColor, value:  UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1), range: NSRange(location: 0,length: 10))
        currenciesLabel.attributedText = mutableCurrenciesString
    }
    
    private func configureView() {
        mainContainer.clipsToBounds = true
        topContainer.backgroundColor =  UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1)
        bottomContainer.backgroundColor =  UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1)
        
        let tapGesture = UITapGestureRecognizer()
        bottomContainer.addGestureRecognizer(tapGesture)
        
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        
        makeConstraints()
        updateAppearance()
    }
    
    private func makeConstraints() {
        contentView.addSubview(mainContainer)
        
        
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [topContainer, bottomContainer].forEach { view in
            mainContainer.addSubview(view)
        }
        
        topContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(72)
        }
        
        topContainer.snp.prepareConstraints { make in
            collapsedConstraint = make.bottom.equalToSuperview().constraint
            collapsedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
        
        topContainer.addSubview(arrowImageView)
        
        [flagImage, topStackView].forEach { view in
            topContainer.addSubview(view)
        }
        
        [learnMoreButton, bottomStackView].forEach { view in
            bottomContainer.addSubview(view)
        }
        
        flagImage.snp.makeConstraints { make in
            make.top.left.equalTo(12)
            make.width.equalTo(82)
            make.height.equalTo(48)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.height.equalTo(48)
            make.left.equalTo(flagImage.snp.right).offset(12)
            make.right.equalTo(arrowImageView.snp.left).offset(-12)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(flagImage.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(24)
            make.centerY.equalTo(contentView.center.y)
            make.right.equalToSuperview().offset(-20)
        }
        
        bottomContainer.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(118)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(bottomStackView.snp.bottom).offset(12)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        bottomContainer.snp.prepareConstraints { make in
            expandedConstraint = make.bottom.equalToSuperview().constraint
            expandedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
    }
}
