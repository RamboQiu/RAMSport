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

class RAMSportMainController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    lazy var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mapView.setCenter(CLLocationCoordinate2DMake(30.1972714600,120.2244975600), animated: true)
        
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = 1.0
//        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true
//
//        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
//        switch status {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .denied:
//            print("denied")// 这里提示用户去设置中心开通定位服务
//        case .restricted:
//            print("restricted")// 这里提示用户无法使用定位
//        default:
//            locationManager.requestWhenInUseAuthorization()
//        }
//        locationManager.startUpdatingLocation()
        
    }

    @IBAction func resetLocationAction(_ sender: UIButton) {
        
//        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        
        let xmlAnalysis = RAMGPXAnalysis()
        let xml = xmlAnalysis.xml
        let allTrkpt: [XMLIndexer] = xml!["gpx"]["trk"]["trkseg"]["trkpt"].all

        let startPoint = MKPointAnnotation()
        var lat: String = allTrkpt.first?.element?.attribute(by: "lat")?.text ?? "0"
        var lon: String = allTrkpt.first?.element?.attribute(by: "lon")?.text ?? "0"
        startPoint.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
        startPoint.title = "start"
        mapView.addAnnotation(startPoint)

        let endPoint = MKPointAnnotation()
        lat = allTrkpt.first?.element?.attribute(by: "lat")?.text ?? "0"
        lon = allTrkpt.first?.element?.attribute(by: "lon")?.text ?? "0"
        endPoint.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
        endPoint.title = "end"
        mapView.addAnnotation(endPoint)

        var points:[CLLocationCoordinate2D] = []
        for xmlIndexer in allTrkpt {
            lat = xmlIndexer.element?.attribute(by: "lat")?.text ?? "0"
            lon = xmlIndexer.element?.attribute(by: "lon")?.text ?? "0"
            points.append(CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!))
        }

        let polylines: MKPolyline = MKPolyline(coordinates: &points, count: points.count)
        mapView.addOverlay(polylines)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: startPoint.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        let mapType: MKMapType = MKMapType(rawValue: UInt(sender.selectedSegmentIndex))!
        mapView.mapType = mapType
    }
    
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("lang: \(userLocation.coordinate.latitude), long: \(userLocation.coordinate.longitude)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // ------- 自带的大头针-----
        var annotationView: MKPinAnnotationView!
        if let annotationViewTmp: MKPinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PIN") as? MKPinAnnotationView {
            annotationView = annotationViewTmp
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN")
        }
//             UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
//
//            imageView.frame=CGRectMake(0,0,50,50);
//
//            annotationView.leftCalloutAccessoryView=imageView;

        annotationView.canShowCallout = true;
        annotationView.animatesDrop = true;

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30));

        label.text = ">>";
        
        annotationView.rightCalloutAccessoryView = label;

        annotationView.pinTintColor = .purple;

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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRenderer = MKPolylineRenderer(overlay: overlay)
        lineRenderer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        lineRenderer.lineWidth = 2
        return lineRenderer
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation! = locations.last
//        //设置region---就是设置地图缩放 1°约等于111KM
//        let region: MKCoordinateRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        mapView.setRegion(region, animated: true)
//
//        let pointAnnotation: MKPointAnnotation = MKPointAnnotation()
//
//        //设置经纬度
//        pointAnnotation.coordinate = location.coordinate;
//
//        //设置主标题
//
//        pointAnnotation.title = "The location of the I"
//
//        //设置副标题
//
//        pointAnnotation.subtitle = "Hello Map"
//
//        //将大头针添加到地图上
//        mapView.addAnnotation(pointAnnotation)
    }
    
    // MARK: - gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

