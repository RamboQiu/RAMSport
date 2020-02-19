//
//  RAMUserRecordSectionHeaderView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/19.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import SnapKit

class RAMUserRecordSectionHeaderView: UITableViewHeaderFooterView {

    var titleLabel = UILabel()
    var descLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
//        contentView
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-15)
        }
        
        descLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.textColor = UIColor.gray
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-15)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
