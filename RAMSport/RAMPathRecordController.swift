//
//  RAMPathRecordController.swift
//  RAMSport
//
//  Created by rambo on 2020/2/16.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import MapKit
import SWXMLHash

class RAMPathRecordController: UIViewController {

    var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPathActiom(_ sender: UIButton) {
        let xmlAnalysis = RAMGPXAnalysis()
        let xml = xmlAnalysis.xml
        let allTrkpt: [XMLIndexer] = xml!["gpx"]["trk"]["trkseg"]["trkpt"].all

        let startPoint = MKPointAnnotation()
        var lat: String = allTrkpt.first?.element?.attribute(by: "lat")?.text ?? "0"
        var lon: String = allTrkpt.first?.element?.attribute(by: "lon")?.text ?? "0"
        startPoint.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
        startPoint.title = "start"
        mapView?.addAnnotation(startPoint)

        let endPoint = MKPointAnnotation()
        lat = allTrkpt.last?.element?.attribute(by: "lat")?.text ?? "0"
        lon = allTrkpt.last?.element?.attribute(by: "lon")?.text ?? "0"
        endPoint.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
        endPoint.title = "end"
        mapView?.addAnnotation(endPoint)

        var points:[CLLocationCoordinate2D] = []
        for xmlIndexer in allTrkpt {
            lat = xmlIndexer.element?.attribute(by: "lat")?.text ?? "0"
            lon = xmlIndexer.element?.attribute(by: "lon")?.text ?? "0"
            points.append(CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!))
        }

        let polylines: MKPolyline = MKPolyline(coordinates: &points, count: points.count)
        mapView?.addOverlay(polylines)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: startPoint.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView?.setRegion(region, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
