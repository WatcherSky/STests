//
//  HeaderCollectionReusableView.swift
//  STestApp
//
//  Created by Владимир on 16.05.2023.
//

import UIKit
import SnapKit

class HeaderCollectionReusableView: UICollectionReusableView {
    lazy var sectionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Bold", size: 15)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func makeConstraints() {
        self.addSubview(sectionTitle)
        
        sectionTitle.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }
}
