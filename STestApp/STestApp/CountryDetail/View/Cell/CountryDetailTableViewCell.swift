//
//  CountryDetailTableViewCell.swift
//  STestApp
//
//  Created by Владимир on 05.06.2023.
//

import UIKit

class CountryDetailTableViewCell: UITableViewCell {
    
    private let bullet = "•"
    
    lazy var countryPropertyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        return label
    }()
    
    lazy var countryDataLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var bulletLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] =  UIFont.preferredFont(forTextStyle: .largeTitle)
        attributes[.foregroundColor] =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle
        
        label.attributedText = NSAttributedString(string: bullet, attributes: attributes)
        return label
    }()

     func configureView() {
        [countryPropertyLabel, countryDataLabel, bulletLabel].forEach {
            contentView.addSubview($0)
        }
         
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        countryPropertyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(48)
            make.right.equalTo(-16)
            make.height.equalTo(18)
        }
        
        countryDataLabel.snp.makeConstraints { make in
            make.top.equalTo(countryPropertyLabel.snp.bottom).offset(4)
            make.left.equalTo(48)
            make.right.equalTo(-16)
            
        }
        
        bulletLabel.snp.makeConstraints { make in
            make.top.equalTo(countryPropertyLabel.snp.top).offset(5)
            make.right.equalTo(countryPropertyLabel.snp.left).offset(-8)
            make.width.equalTo(24)
            make.height.equalTo(16)
        }
    }
}
