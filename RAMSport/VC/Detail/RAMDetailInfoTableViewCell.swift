//
//  RAMDetailInfoTableViewCell.swift
//  RAMSport
//
//  Created by rambo on 2020/2/20.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMDetailInfoTableViewCell: UITableViewCell {
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        return label
    }()
    lazy var distanceDescLabel = self.label(text:"公里")
    
    var distance = 0.0 {
        didSet {
            distanceLabel.text = Float(self.distance).clearString
            distanceLabel.sizeToFit()
            distanceLabel.snp.updateConstraints { (make) in
                make.width.equalTo(self.distanceLabel.width)
                make.height.equalTo(self.distanceLabel.height)
            }
        }
    }
    
    lazy var speedLabel = self.titleLabel()
    lazy var speedDescLabel = self.label(text:"配速")
    
    lazy var timeLabel = self.titleLabel()
    lazy var timeDescLabel = self.label(text:"时间")
    
    lazy var kaluliLabel = self.titleLabel()
    lazy var kaluliDescLabel = self.label(text:"卡路里")
    
    lazy var upLabel = self.titleLabel()
    lazy var upDescLabel = self.label(text:"爬升")
    
    lazy var downLabel = self.titleLabel()
    lazy var downDescLabel = self.label(text:"下降")
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(40)
            make.height.equalTo(70)
        }
        contentView.addSubview(distanceDescLabel)
        distanceDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.distanceLabel.snp.right).offset(5)
            make.bottom.equalTo(self.distanceLabel).offset(-12)
            make.width.equalTo(self.distanceDescLabel.width)
            make.height.equalTo(self.distanceDescLabel.height)
        }
        
        contentView.addSubview(speedLabel)
        speedLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(self.distanceLabel.snp.bottom).offset(5)
            make.width.equalTo((RAMScreenWidth-50)/3)
            make.height.equalTo(30)
        }
        contentView.addSubview(speedDescLabel)
        speedDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.speedLabel)
            make.top.equalTo(self.speedLabel.snp.bottom)
            make.width.equalTo(self.speedLabel)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.speedLabel.snp.right).offset(10)
            make.top.width.height.equalTo(self.speedLabel)
        }
        contentView.addSubview(timeDescLabel)
        timeDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel)
            make.top.width.height.equalTo(self.speedDescLabel)
        }
        
        contentView.addSubview(kaluliLabel)
        kaluliLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.right).offset(10)
            make.top.width.height.equalTo(self.speedLabel)
        }
        contentView.addSubview(kaluliDescLabel)
        kaluliDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.kaluliLabel)
            make.top.width.height.equalTo(self.speedDescLabel)
        }
        
        /// 第二行
        
        contentView.addSubview(upLabel)
        upLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(self.speedDescLabel.snp.bottom).offset(10)
            make.width.height.equalTo(self.speedLabel)
        }
        contentView.addSubview(upDescLabel)
        upDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.upLabel)
            make.top.equalTo(self.upLabel.snp.bottom)
            make.width.height.equalTo(self.speedDescLabel)
        }
        
        contentView.addSubview(downLabel)
        downLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.upLabel.snp.right).offset(10)
            make.top.width.height.equalTo(self.upLabel)
        }
        contentView.addSubview(downDescLabel)
        downDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.downLabel)
            make.top.width.height.equalTo(self.upDescLabel)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }
    
    func label(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.sizeToFit()
        return label
    }
    
    class func cellHeight() -> CGFloat {
        return 207
    }

}
