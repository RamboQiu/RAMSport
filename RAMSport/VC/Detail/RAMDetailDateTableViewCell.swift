//
//  RAMDetailDateTableViewCell.swift
//  RAMSport
//
//  Created by rambo on 2020/2/19.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import SnapKit

class RAMDetailDateTableViewCell: UITableViewCell {
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    lazy var editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_edit")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(15)
        }
        
        contentView.addSubview(editImageView)
        editImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.height.width.equalTo(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalTo(self.editImageView)
            make.height.equalTo(30)
            make.right.equalTo(self.editImageView.snp.left).offset(-10)
        }
        
        _ = ram_addLine(atVertical: .AtBottom, left: 15, right: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat {
        return 80
    }
    
}
