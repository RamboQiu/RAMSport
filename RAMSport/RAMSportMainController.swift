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
    
    lazy var locationManager: CLLocationManager = {
        let locationM = CLLocationManager()
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        locationM.distanceFilter = 1.0
        locationM.delegate = self
        locationM.allowsBackgroundLocationUpdates = true
        return locationM
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyClearNavigationBarStyle()
        
//        navigationController?.navigationBar.set
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
        
//        let mainQueue = DispatchQueue.main
//        mainQueue.asyncAfter(deadline: .now() + 3) {
//            self.locateUserLocation()
//        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return ram_statusBarStyle
    }
    
    func locateUserLocation() {
//        lat="30.602198" lon="119.868523"
        let userLocation = self.mapView.userLocation.coordinate
//        mapView.setCenter(userLocation, animated: true)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        let mapType: MKMapType = MKMapType(rawValue: UInt(sender.selectedSegmentIndex))!
        mapView.mapType = mapType
    }
    
    @IBAction func startSport(_ sender: UIButton) {
        
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
        print("mapView:didUpdate: - lang: \(userLocation.coordinate.latitude), long: \(userLocation.coordinate.longitude)")
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // ------- 自带的大头针-----
        var annotationView: MKMarkerAnnotationView!
        if let annotationViewTmp: MKMarkerAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PIN") as? MKMarkerAnnotationView {
            annotationView = annotationViewTmp
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN")
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRenderer = MKPolylineRenderer(overlay: overlay)
        lineRenderer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        lineRenderer.lineWidth = 2
        return lineRenderer
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager:didUpdateLocations: - lang: \(locations.first?.coordinate.latitude), long: \(locations.first?.coordinate.longitude)")
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

