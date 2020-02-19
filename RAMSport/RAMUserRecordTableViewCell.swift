//
//  RAMUserRecordTableViewCell.swift
//  RAMSport
//
//  Created by rambo on 2020/2/19.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import SnapKit

class RAMUserRecordTableViewCell: UITableViewCell {
    
    var headImageView = UIImageView()
    var timeLabel = UILabel()
    var titleLabel = UILabel()
    var descLabel = UILabel()
    var arrowImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headImageView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        contentView.addSubview(headImageView)
        headImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(64)
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.backgroundColor = UIColor.black
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.centerY.equalTo(self.headImageView)
            make.right.equalToSuperview().offset(-15)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(12)
            make.centerY.equalTo(self.headImageView)
            make.height.equalTo(20)
            make.right.equalTo(self.arrowImageView.snp.left).offset(5)
        }
        
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(2)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-15)
        }
        
        descLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.textColor = UIColor.gray
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(-2)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
