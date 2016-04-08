//
//  MapViewController.swift
//  Training
//
//  Created by Lukasz on 07/04/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import SnapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        mapView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.didLongPress(_:)))
        mapView.addGestureRecognizer(gesture)
        
        startRequest()
    }
    
    func didLongPress(sender: UIGestureRecognizer) {
        guard sender.state == .Began else { return }
        
        let point = sender.locationInView(mapView)
        let coordinate = mapView.convertPoint(point, toCoordinateFromView: mapView)
        
        let pin = DataPin(data: LocatedData(lat: coordinate.latitude, lng: coordinate.longitude))
        
        mapView.addAnnotation(pin)
    }
    
    
    private func showData(data: [LocatedData]) {
        let annotations = data.map { (data: LocatedData) -> (DataPin) in
            return DataPin(data: data)
        }
        mapView.addAnnotations(annotations)
    }
    
    
    
    private func startRequest() {
        Alamofire.request(.GET, "https://trainingplaces.firebaseio.com/locations.json").responseJSON { (response) in
            
            // TODO: Check
            
            
            let json = response.result.value as! [String: [String:Double]]
            
            let data = json.map { (key, val) in
                LocatedData(lat: val["lat"]!, lng: val["lng"]!)
            }
            
            print("array size: \(data.count)")
            self.showData(data)
        }
    }
    
    
}

struct LocatedData {
    let lat: Double
    let lng: Double
}


class DataPin : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(data: LocatedData) {
        coordinate = CLLocationCoordinate2D(latitude: data.lat, longitude: data.lng)
    }
}






