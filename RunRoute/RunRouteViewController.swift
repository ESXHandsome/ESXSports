//
//  ViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/13.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class RunRouteViewController: UIViewController,AMapSearchDelegate,AMapLocationManagerDelegate,MAMapViewDelegate {
    var locationManage : AMapLocationManager?
    var mapView : MAMapView?
    var search : AMapSearchAPI?
    var coordinateArray: [CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        
        button.frame = CGRect(x: M_WIDTH/2 - 150, y: M_HEIGHT/9, width: 120, height: 60)
//        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(routeDone), for: .touchUpInside)
        button.layer.borderWidth = 2
        button.setTitle("结束", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 16
        AMapServices.shared().apiKey = "0cb691de615bcbf985e6d2882c33f415"
        let button1 = UIButton()
        button1.frame = CGRect(x: M_WIDTH/2+30, y: M_HEIGHT/9, width: 120, height: 60)
//        button1.backgroundColor = UIColor.red
        button1.addTarget(self, action: #selector(routeStart), for: .touchUpInside)
        button1.setTitle("开始", for: .normal)
        button1.setTitleColor(UIColor.red, for: .normal)
        button1.layer.borderWidth = 2
        button1.layer.cornerRadius = 16
        button1.layer.borderColor = UIColor.red.cgColor
        mapView = MAMapView()
        mapView?.frame = UIScreen.main.bounds
        
        self.view.addSubview(mapView!)
        initMapView()
        self.mapView?.addSubview(button1)
        self.mapView?.addSubview(button)
    }
    
    
    func routeDone(){
        endLocation()
        
//        dismiss(animated: true, completion: nil)
    }
    func routeStart (){
        endLocation()
        startLocation()
        startLocation()
//        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView?.isShowsUserLocation = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
   
    func initMapView()
    {
        mapView?.delegate = self
        mapView?.zoomLevel = 15.5
        mapView?.distanceFilter = 3.0
        mapView?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func startLocation()
    {
        // 开始定位
        mapView?.isShowsUserLocation = true
        mapView?.userTrackingMode = MAUserTrackingMode.follow
        mapView?.pausesLocationUpdatesAutomatically = false
        mapView?.allowsBackgroundLocationUpdates = true
    }
    
    func endLocation()
    {
        // 定位结束
        mapView?.isShowsUserLocation = false
    }
    
    func updatePath () {
        
        // 每次获取到新的定位点重新绘制路径
        // 移除掉除之前的overlay
        let overlays = self.mapView?.overlays
        self.mapView?.removeOverlays(overlays)
        
        let polyline = MAPolyline(coordinates: &self.coordinateArray, count: UInt(self.coordinateArray.count))
        self.mapView?.add(polyline)
        
        // 将最新的点定位到界面正中间显示
        let lastCoord = self.coordinateArray[self.coordinateArray.count - 1]
        self.mapView?.setCenter(lastCoord, animated: true)
    }
    
    // MARK: MAMapViewDelegate
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        // 地图每次有位置更新时的回调
        
        if updatingLocation {
            // 获取新的定位数据
            let coordinate = userLocation.coordinate
            
            // 添加到保存定位点的数组
            self.coordinateArray.append(coordinate)
            
            updatePath()
            
        }
    }
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay.isKind(of: MAPolyline.self) {
            let polylineRenderer = MAPolylineRenderer.init(polyline: overlay as! MAPolyline!
            )
            polylineRenderer?.lineWidth = 15
            polylineRenderer?.strokeColor = UIColor(red: 4 / 255.0, green:  181 / 255.0, blue:  108 / 255.0, alpha: 1.0)
            polylineRenderer?.lineJoin = .round
            polylineRenderer?.lineCap = .round
            
            return polylineRenderer
        }
        
        return nil
    }
}
