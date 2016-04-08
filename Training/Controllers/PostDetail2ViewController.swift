//
//  PostDetail2ViewController.swift
//  Training
//
//  Created by Lukasz on 05/04/16.
//  Copyright © 2016 Konsent. All rights reserved.
//
//
// 1 - MapKit
// 2 - MKMapView() + add + constraint
// 3 - Center map on user with region
// 4 - Class Pin : MKAnnotation
// 5 - MKMapviewDelegate
// 6 - mapView viewForAnnotation
// 7 - MKPinAnnotationView
// 
// 
//



import UIKit
import Alamofire
import MapKit

class PostDetail2ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
//    private var v: PostDetail2View {
//        return view as! PostDetail2View
//    }
    
    private let post: Post
    private let mapView = MKMapView()
    
    private let locationManager = CLLocationManager()
    
    private let userView = UIView()
    private let userNameLabel = UILabel()
    private let userActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PostDetail2View()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post.title

        setupView()
        startRequest()
        
        // PLIST: NSLocationWhenInUseUsageDescription
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            showUserOnMap()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // MARK: View
    
    private func setupView() {
        view.backgroundColor = UIColor.whiteColor()
        
        // scrollview
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        // contentview
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        
        // post title
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.top.equalTo(contentView).offset(80)
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.text = post.title
        
        // post body
        let bodyLabel = UILabel()
        contentView.addSubview(bodyLabel)
        
        bodyLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.top.equalTo(titleLabel.snp_bottom).offset(20)
        }
        
        bodyLabel.numberOfLines = 0
        bodyLabel.text = post.body
        
        
        // user
        
        contentView.addSubview(userView)
        userView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(bodyLabel.snp_bottom).offset(20)
        }
        
        // userview is hidden at first until user is loaded
        userView.alpha = 0
        
        userView.addSubview(userNameLabel)
        userNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(userView).offset(20)
            make.right.equalTo(userView).offset(-20)
            make.top.equalTo(userView)
        }
        
        userNameLabel.numberOfLines = 0
        
        userView.addSubview(mapView)
        mapView.snp_makeConstraints { (make) in
            make.height.equalTo(250)
            make.left.equalTo(userView).offset(20)
            make.right.equalTo(userView).offset(-20)
            make.top.equalTo(userNameLabel.snp_bottom).offset(20)
            make.bottom.equalTo(userView).offset(20)
        }
        
        
        
        // activity indicator
        // loading at first until the user is loaded
        view.addSubview(userActivityIndicatorView)
        userActivityIndicatorView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(20)
        }
        userActivityIndicatorView.startAnimating()
    }
    
    private func bindUser(user: User) {
        // name label
        userNameLabel.text = user.name
        
//        // center map
//        let centerCoordinate = CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude)
//        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
//        
//        // option1
//        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
//        
//        // option2
//        let region2 = MKCoordinateRegionMakeWithDistance(centerCoordinate, 1000, 1000)
//        
//        
//        mapView.setRegion(region, animated: true)
        
        // add pin to map
        let pin = Pin(user: user)
        mapView.addAnnotation(pin)
        
        
        // etc
        
        userView.alpha = 0
        
        UIView.animateWithDuration(0.6) {
            self.userView.alpha = 1
        }
    }
    
    
    // MARK: Map
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let pin = annotation as? Pin else { return nil }
        
        let view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin")
        if(view != nil) {
            return view
        }
        
        let newView = MKPinAnnotationView(annotation: pin, reuseIdentifier: "pin")
        newView.pinTintColor = UIColor.yellowColor()
        newView.canShowCallout = true
        newView.calloutOffset = CGPoint(x: -10, y: -10)
        newView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return newView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let pin = view.annotation as! Pin
        let user = pin.user
        
        print("tapped \(user.name)")
    }
    
    
    private func showUserOnMap() {
        mapView.showsUserLocation = true
        
        if let l = locationManager.location {
            let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: l.coordinate.latitude, longitude: l.coordinate.longitude), 100, 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK: Location
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            showUserOnMap()
        }
    }
    
    
    // MARK: Request
    
    private func startRequest() {
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/users/\(post.userId)").responseJSON { [weak self]
            (response) in
            
            guard let s = self else { return }
            
            s.userActivityIndicatorView.hidden = true
            
            guard let json = response.result.value as? [String:AnyObject] else {
                return
            }
            
            let addressJson = json["address"] as? [String:AnyObject] ?? [String:AnyObject]()
            let geoJson = addressJson["geo"] as? [String:String] ?? [String:String]()
            
            let user = User(name: json["name"] as? String ?? "", username: json["username"] as? String ?? "", latitude: Double(geoJson["lat"] ?? "0.0") ?? 0.0, longitude: Double(geoJson["lng"] ?? "0.0") ?? 0.0)
            
            
            // check fields blank
            // TODO
            
            // then
            s.bindUser(user)
        }
    }
}

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    let user: User
    
    init(user: User) {
        self.user = user
        
        coordinate = CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude)
        
        title = user.name
        subtitle = user.username
    }
}














