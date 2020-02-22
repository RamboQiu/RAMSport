//
//  ViewController.swift
//  RAMSport
//
//  Created by rambo on 2020/2/12.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SWXMLHash

class RAMSportMainController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headView: RAMSportMainHeadView!
    @IBOutlet weak var centerCircleView: RAMSportMainCenterCircleView!
    @IBOutlet weak var recordGraphView: RAMSportMainRecordGraphView!
    @IBOutlet weak var manuView: UIView!
    @IBOutlet weak var addView: RAMSportMainAddView!
    
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyClearNavigationBarStyle()
        
        mapView.userTrackingMode = .follow
        
        recordGraphView.layer.cornerRadius = 20
        manuView.layer.cornerRadius = 20
        headView.headImageView.layer.cornerRadius = headView.headImageView.width / 2
        addView.layer.cornerRadius = addView.width / 2
        centerCircleView.angle = .pi / 2
        
        recordGraphView.speedCurveView.title = "5'33'' /km"
        recordGraphView.distanceCurveView.title = "8 km"
        
        let tapRecordGesture = UITapGestureRecognizer(target: self, action: #selector(routeTo(record:)))
        recordGraphView.addGestureRecognizer(tapRecordGesture)
        
        let tapRunningGesture = UITapGestureRecognizer(target: self, action: #selector(routeTo(running:)))
        centerCircleView.addGestureRecognizer(tapRunningGesture)
        
        
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("denied")// 这里提示用户去设置中心开通定位服务
        case .restricted:
            print("restricted")// 这里提示用户无法使用定位
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerCircleView.layer.cornerRadius = centerCircleView.width / 2
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return ram_statusBarStyle
    }
    
    @objc func routeTo(running tapGesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "running", sender: self)
    }
    
    @objc func routeTo(record tapGesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "record", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pathRecord" {
            if let vc = segue.destination as? RAMPathRecordController {
                vc.mapView = mapView
            }
        }
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude + 0.0001, longitude: userLocation.coordinate.longitude - 0.0015)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.setRegion(region, animated: true)
    }
}

