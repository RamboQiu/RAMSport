# RAMSport

### 1. 记录开发过程中碰到的问题

1. MKPolylineRenderer 要使用strokeColor，不要使用fillColor，不然画出的线会看不到

   ```swift
   func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           let lineRenderer = MKPolylineRenderer(overlay: overlay)
           lineRenderer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
           lineRenderer.lineWidth = 2
           return lineRenderer
   }
   ```

   fill和stroke是绘图相关基础，不是闭合的路径无法fill

2. swift的指针参数赋值 UnsafePointer ，使用&

   ```swift
   var points:[CLLocationCoordinate2D] = []
   for xmlIndexer in allTrkpt {
     lat = xmlIndexer.element?.attribute(by: "lat")?.text ?? "0"
     lon = xmlIndexer.element?.attribute(by: "lon")?.text ?? "0"
     points.append(CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!))
   }
   
   let polylines: MKPolyline = MKPolyline(coordinates: &points, count: points.count)
   ```

   

## 待完善的功能

1. 运动监听，生成轨迹
2. 运动的本地记录方式
3. 运动轨迹导出gpx
4. 第三方，如微信，好友打开gpx，可以选择使用该程序打开