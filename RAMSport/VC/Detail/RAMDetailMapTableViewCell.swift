//
//  RAMDetailMapTableViewCell.swift
//  RAMSport
//
//  Created by rambo on 2020/2/20.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import MapKit

class RAMDetailMapTableViewCell: UITableViewCell, MKMapViewDelegate {
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.clipsToBounds = true
        map.layer.cornerRadius = 4
//        map.isZoomEnabled = false
//        map.isRotateEnabled = false
//        map.isScrollEnabled = false
//        map.isPitchEnabled = false
        map.isUserInteractionEnabled = false
        return map
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    class func cellHeight() -> CGFloat {
        return 400.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
