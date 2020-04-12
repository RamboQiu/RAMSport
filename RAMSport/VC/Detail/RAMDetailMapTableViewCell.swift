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
    
    var gpxModel : RAMGPXModel? {
        didSet {
            if let startWpt = gpxModel!.trk.first?.trkseg.first {
                let startPoint = MKPointAnnotation()
                startPoint.coordinate = CLLocationCoordinate2D(latitude: startWpt.lat, longitude: startWpt.lon)
                let (n_lat,n_lng) = CLLocation.transform_earth_from_mars(lat: startPoint.coordinate.latitude, lng: startPoint.coordinate.longitude)
                startPoint.coordinate = CLLocationCoordinate2D(latitude: startPoint.coordinate.latitude + n_lat, longitude: startPoint.coordinate.longitude + n_lng)
                startPoint.title = "start"
                mapView.addAnnotation(startPoint)
            }
            
            var points:[CLLocationCoordinate2D] = []
            for gpxTrkModel in gpxModel!.trk {
                for gpxWptModel in gpxTrkModel.trkseg {
                    points.append(CLLocationCoordinate2D(latitude: gpxWptModel.lat, longitude: gpxWptModel.lon))
                }
            }
            
            if points.count > 0 {
                if let endCoordinate = points.last  {
                    let endPoint = MKPointAnnotation()
                    endPoint.coordinate = endCoordinate
                    endPoint.title = "end"
                    mapView.addAnnotation(endPoint)
                }
                
                let polylines: MKPolyline = MKPolyline(coordinates: &points, count: points.count)
                mapView.addOverlay(polylines)
                let region: MKCoordinateRegion = MKCoordinateRegion(center: points.first!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                mapView.setRegion(region, animated: true)
            }
        }
    }

    
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRenderer = MKPolylineRenderer(overlay: overlay)
        lineRenderer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lineRenderer.lineWidth = 2
        return lineRenderer
    }
}
