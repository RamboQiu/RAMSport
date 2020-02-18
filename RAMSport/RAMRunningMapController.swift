//
//  RAMRunningMapController.swift
//  RAMSport
//
//  Created by rambo on 2020/2/17.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class RAMRunningMapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    
    var userPoints:[CLLocation] = []
    lazy var timer: Timer = {
        let t = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeRun), userInfo: nil, repeats: true)
        
        RunLoop.current.add(t, forMode: .common)
        return t
    }()
    
    let runModel = RAMRunModel()
    
    var distance: Double = 0.0 {
        didSet {
            distanceLabel.text = "\(String(format: "%.2f", self.distance/1000))"
            runModel.distance = self.distance / 1000
        }
    }
    
    var speed: Double = 0.0 {
        didSet {
            speedLabel.text = "\(String(format: "%.0f", self.speed))"
            runModel.speed = Int(self.speed)
        }
    }
    
    var time: Int = 0 {
        didSet {
            timeLabel.text = "\(self.time)"
            runModel.time = self.time
        }
    }
    
    var upDistance: Double = 0.0 {
        didSet {
            upLabel.text = "\(self.upDistance)"
            runModel.upDistance = self.upDistance
        }
    }
    
    var downDistance: Double = 0.0 {
        didSet {
            upLabel.text = "\(self.downDistance)"
            runModel.downDistance = self.downDistance
        }
    }
    
    
    lazy var locationManager: CLLocationManager = {
        let locationM = CLLocationManager()
        locationM.activityType = .fitness
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        locationM.delegate = self
        locationM.allowsBackgroundLocationUpdates = true
//        locationM.showsBackgroundLocationIndicator = false
        return locationM
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
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
        
        mapView.userTrackingMode = .follow
    }
        
    @IBAction func beginRun(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        timer.fireDate = Date()
        
    }
    
    @IBAction func pauseRun(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
        
        timer.fireDate = Date.distantFuture
    }
    
    @IBAction func endRun(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
        timer.invalidate()
        
        let realm = try! Realm() // Create realm pointing to default file
        realm.beginWrite()
        realm.add(runModel)
        try! realm.commitWrite()
        
    }
    
    @objc func timeRun() {
        time += 1
    }
    // MARK: - MKMapViewDelegate
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        print("mapView:didUpdate: - lang: \(userLocation.coordinate.latitude), long: \(userLocation.coordinate.longitude)")
//
////        let region: MKCoordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
////        mapView.setRegion(region, animated: true)
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        // ------- 自带的大头针-----
        var annotationView: MKMarkerAnnotationView!
        if let annotationViewTmp: MKMarkerAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "mark") as? MKMarkerAnnotationView {
            annotationView = annotationViewTmp
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "mark")
        }
//             UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
//
//            imageView.frame=CGRectMake(0,0,50,50);
//
//            annotationView.leftCalloutAccessoryView=imageView;

        annotationView.canShowCallout = true;
//        annotationView.animatesDrop = true;

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30));

        label.text = ">>";
        
        annotationView.rightCalloutAccessoryView = label;

//        annotationView.pinTintColor = .purple;

        return annotationView;

//         自定义大头针-------

//          static NSString *pinId = "pinID";
//
//          MKAnnotationView *annoView = [mapView  dequeueReusableAnnotationViewWithIdentifier:pinId];
//
//          if (annoView == nil) {
//
//        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation  reuseIdentifier:pinId];
//
//          }
//
//        annoView.annotation = annotation;
//
//          annoView.image = [UIImage imageNamed:@"2.jpg"];
//
//        annoView.canShowCallout = YES;
//
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
//
//        imageView.bounds = CGRectMake(0, 0, 44, 44);
//
//        annoView.leftCalloutAccessoryView = imageView;    imageView.userInteractionEnabled  = YES;
//
//                UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
//
//          imageView2.bounds = CGRectMake(0, 0, 44, 44);
//
//            annoView.rightCalloutAccessoryView = imageView2;
//
//          annoView.draggable = YES;
//
//          return annoView;
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        // TODO: 设置指向箭头 https://www.jianshu.com/p/9416839138e8
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRenderer = MKPolylineRenderer(overlay: overlay)
        lineRenderer.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lineRenderer.lineWidth = 2
        return lineRenderer
    }
    
    // MARK: - CLLocationManagerDelegate
    /**
     * 我们在此方法中取到的经纬度依据的标准是地球坐标,但是国内的地图显示按照的标准是火星坐标
     * MKMapView 不用在做任何的处理,是因为 MKMapView 是已经经过处理的
     * 也就导致此方法中获取的坐标在 mapView 上显示是有偏差的
     * https://www.2cto.com/kf/201607/526888.html
     * https://www.jianshu.com/p/b0ac482fa779
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
//            location = location.locationEarthFromMars()
            let coordinate = location.coordinate
            
            if let lastLocation = userPoints.last {
                
                distance += location.distance(from: lastLocation)
                
                let altitude = location.altitude - lastLocation.altitude
                if altitude > 0 {
                    upDistance += altitude
                } else {
                    downDistance -= altitude
                }
                
                speed = Double(1000 * time) / distance // 每公里耗时速度
                
                var moveTwo = [CLLocationCoordinate2D]()
                moveTwo.append(lastLocation.coordinate)
                moveTwo.append(coordinate)
                let line = MKPolyline(coordinates: &moveTwo, count: moveTwo.count)
                mapView.addOverlay(line)
            }
            
//            mapView.userLocation
            
            mapView.setCenter(coordinate, animated: true)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate,
                                                                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)

            userPoints.append(location)
            
            let wptModel = RAMGPXWptModel()
            wptModel.lat = location.coordinate.latitude
            wptModel.lon = location.coordinate.longitude
            wptModel.ele = location.altitude
            wptModel.speed = location.speed
            
            if let trkModel = runModel.gpxPath?.trk.first {
                trkModel.trkseg.append(wptModel)
            } else {
                let trkModel = RAMGPXTrkModel()
                runModel.gpxPath?.trk.append(trkModel)
                trkModel.trkseg.append(wptModel)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }

}
