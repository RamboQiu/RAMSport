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
import AudioToolbox
import RxSwift
import RxCocoa

class RAMRunningMapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var pauseButton: RAMRunningPauseView!
    @IBOutlet weak var endButton: RAMRunningEndView!
    @IBOutlet weak var startButton: RAMRunningStartView!
    @IBOutlet weak var runningInfoView: RAMRunningInfoView!
    
    
    let disposeBag = DisposeBag()
    
    var animated = false
    
    lazy private(set) var realm: Realm! = {
        let r = try! Realm()
        r.beginWrite()
        return r
    }()
    
    var userPoints:[CLLocation] = []
    lazy var timer: Timer = {
        let t = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeRun), userInfo: nil, repeats: true)
        
        RunLoop.current.add(t, forMode: .common)
        return t
    }()
    
    lazy var runMonthModel: RAMMonthRunModel = {
        let calendar = NSCalendar.current
        let dateComponent = calendar.dateComponents([.year, .month], from: Date())
        let year = dateComponent.year!
        let month = dateComponent.month!
//        let predicate = NSPredicate(format: "month = %@", runModel.month! as NSDate)
        let results = realm.objects(RAMMonthRunModel.self).filter("year == \(year) && month == \(month)")
        if let monthRunModel = results.first {
            return monthRunModel
        } else {
            let monthRunModel = RAMMonthRunModel()
            monthRunModel.year = year
            monthRunModel.month = month
            realm.add(monthRunModel)
            return monthRunModel
        }
    }()
    
    lazy var runModel: RAMRunModel = {
        let runModel = RAMRunModel()
        let date = runModel.date
        let calendar = NSCalendar.current
        let dateComponent = calendar.dateComponents([.year, .month, .day], from: date)
        runModel.year = dateComponent.year!
        runModel.month = dateComponent.month!
        runModel.day = dateComponent.day!
        runMonthModel.runs.append(runModel)
        return runModel
    }()
    
    var distance: Double = 0.0 {
        didSet {
            distanceLabel.text = "\(String(format: "%.2f", self.distance/1000))"
            runModel.distance = self.distance / 1000
        }
    }
    
    var speed: Double = 0.0 {
        didSet {
            let minute = self.speed / 60
            let second = self.speed.truncatingRemainder(dividingBy: 60)
            
            speedLabel.text = "\(String(format: "%.0f'%.0f''", minute, second))"
            runModel.speed = Int(self.speed)
        }
    }
    
    var time: Int = 0 {
        didSet {
            var minute = self.time / 60
            let hour = minute / 60
            minute = minute % 60
            let second = self.time % 60
            var minuteS = "\(minute)"
            if minute < 10 {
                minuteS = "0\(minute)"
            }
            var secondS = "\(second)"
            if second < 10 {
                secondS = "0\(second)"
            }
            if hour > 0 {
                timeLabel.text = "\(hour):\(minuteS):\(secondS)"
            } else {
                timeLabel.text = "\(minuteS):\(secondS)"
            }
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
        locationM.pausesLocationUpdatesAutomatically = false
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
        mapView.width = RAMScreenWidth
        mapView.height = RAMScreenHeight
        
        pauseButton.layer.cornerRadius = pauseButton.width / 2
        endButton.layer.cornerRadius = endButton.width / 2
        startButton.layer.cornerRadius = startButton.width / 2
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panShowMapAction(_:)))
        runningInfoView.addGestureRecognizer(panGesture)

        runningInfoView.y = 142
        runningInfoView.width = RAMScreenWidth
        runningInfoView.height = RAMScreenHeight - runningInfoView.y
        
        self.rx
            .observe(Bool.self, "endButton.ended")
            .subscribe(onNext: { (ended) in
                if ended ?? false {
                    self.endRun()
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "runningComplete" {
            if let vc = segue.destination as? RAMDetailController {
                vc.runModel = runModel
                vc.from = .running
            }
        }
    }
        
    @IBAction func beginRun(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1519)
        locationManager.startUpdatingLocation()
        timer.fireDate = Date()
        
        startButton.isHidden = true
        endButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    @IBAction func pauseRun(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1519)
        locationManager.stopUpdatingLocation()
        
        timer.fireDate = Date.distantFuture
        startButton.isHidden = false
        endButton.isHidden = false
        pauseButton.isHidden = true
    }
    
    func endRun() {
        locationManager.stopUpdatingLocation()
        timer.invalidate()
        if let wpts = runModel.gpxPath?.trk.first?.trkseg {
            mapView.region = region(for: wpts)
        }
        realm.add(runModel)
        try! realm.commitWrite()
        
        performSegue(withIdentifier: "runningComplete", sender: nil)
    }
    
    @objc func longPressEndAction(_ event: UILongPressGestureRecognizer) {
        switch event.state {
        case .began:
            print("1")
//            UIView.animate(withDuration: 0.5, animations: {
//                self.endButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            }) { (finish) in
////                短震  3D Touch中的peek震动反馈
////                AudioServicesPlaySystemSound(1519)
////                //短震  3D Touch中的pop震动反馈
////                AudioServicesPlaySystemSound(1520)
////                //连续三次短震动
////                AudioServicesPlaySystemSound(1521)
//                AudioServicesPlaySystemSound(1519)
//                UIView.animate(withDuration: 0.3) {
//                    self.endButton.transform = CGAffineTransform(scaleX: 1, y: 1)
//                }
//            }
        case .ended:
            print("2")
        case .cancelled:
            print("3")
        case .changed:
            print("4")
        default:
            return
        }
    }
    
    @objc func panShowMapAction(_ event: UIPanGestureRecognizer) {
        if animated {
            return
        }
        let velocity = event.velocity(in: event.view?.superview)
        let translation = event.translation(in: event.view?.superview)
        // 滑动左右偏差10没关系
        if abs(translation.x) < 10 {
            if velocity.y > 500 {
                // 下滑
                hiddenInfoViewAnimate()
            } else if velocity.y < -500 {
                // 上滑
                showInfoViewAnimate()
            }
        }
    }
    
    /// 显示info，隐藏详细地图
    func showInfoViewAnimate() {
        if animated {
            return
        }
        animated = true
//        var frame = self.mapView.frame
//        frame.size.height = 150
        UIView.animate(withDuration: 0.3, animations: {
            self.runningInfoView.y = 142
//            self.mapView.frame = frame
        }) { (finish) in
            self.animated = false
        }
    }
    /// 隐藏info，显示详细地图
    func hiddenInfoViewAnimate() {
        if animated {
            return
        }
        animated = true
//        var frame = self.mapView.frame
//        frame.size.height = RAMScreenHeight - 42
        UIView.animate(withDuration: 0.3, animations: {
            self.runningInfoView.y = RAMScreenHeight - 50
//            self.mapView.frame = frame
        }) { (finish) in
            self.animated = false
        }
    }
    
    func region(for wpts: List<RAMGPXWptModel>) -> MKCoordinateRegion {
        var minLat = 360.0, maxLat = -360.0, minLon = 360.0, maxLon = -360.0
        for wptModel in wpts {
            if wptModel.lat  < minLat {
                minLat = wptModel.lat
            }
            if wptModel.lat  > maxLat {
                maxLat =  wptModel.lat
            }
            if wptModel.lon < minLon {
                minLon = wptModel.lon
            }
            if wptModel.lon > maxLon {
                maxLon = wptModel.lon
            }
        }
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2.0, longitude: (minLon + maxLon) / 2.0)
        let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat + 0.001, longitudeDelta: maxLon - minLon + 0.001)
        let region = MKCoordinateRegion(center: center, span: span)
        return region
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
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//        // TODO: 添加自制大头针
//    }
//
//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
//        // TODO: 设置指向箭头 https://www.jianshu.com/p/9416839138e8
//    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRenderer = MKPolylineRenderer(overlay: overlay)
        lineRenderer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
            print(location)
            
            let coordinate = location.coordinate
            
            if let lastLocation = userPoints.last {
                
                distance += location.distance(from: lastLocation)
                
                let altitude = location.altitude - lastLocation.altitude
                if altitude > 0 {
                    upDistance += altitude
                } else {
                    downDistance -= altitude
                }
                if distance == 0 {
                    speed = 0
                } else {
                    speed = Double(1000 * time) / distance // 每公里耗时速度
                }
                
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
    
//    ///如果你让设备在同一地点约15分钟应该发生 http://cn.voidcc.com/question/p-qpuamcrm-bcx.html
    // TODO: 自动暂停的思考 实现判断多长时间内都没有离开一个区域，认为是暂停了
//    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
//        pauseRun(pauseButton)
//        // 自动暂停逻辑，离开当前区域就恢复启动
//        if let center = manager.location?.coordinate {
//            let region = CLCircularRegion(center: center, radius: 2.0, identifier: "Headquarters")
//            region.notifyOnEntry = false
//            region.notifyOnExit = true
//            manager.startMonitoring(for: region)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        if let region = region as? CLCircularRegion {
//            let identifier = region.identifier
//            if identifier == "Headquarters" {
//                beginRun(startButton)
//                manager.stopMonitoring(for: region)
//            }
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
//
//    }

}
