//
//  ViewController.swift
//  locationAware
//
//  Created by Abdelrahman Hammad on 4/19/17.
//  Copyright © 2017 Abdelrahman Hammad. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

     var locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        latitudeLabel.text = String(userLocation.coordinate.latitude)
        longitudeLabel.text = String(userLocation.coordinate.longitude)
        setmap(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(userLocation){(placemarks,error) in
            if error != nil{
                print( error ?? "Error" )
            }else{
                if let placemark = placemarks?[0] {
                    
                    var subThoroughFare = ""
                    if placemark.subThoroughfare != nil {
                        subThoroughFare = placemark.subThoroughfare!
                    }
                    
                    var thoroughFare = ""
                    if placemark.thoroughfare != nil {
                        thoroughFare = placemark.thoroughfare!
                    }
                    
                    var subLocality = ""
                    if placemark.subLocality != nil {
                        subLocality = placemark.subLocality!
                    }
                    
                    var subAdminArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subAdminArea = placemark.subAdministrativeArea!
                    }
                    
                    var subPostCode = ""
                    if placemark.postalCode != nil {
                        subPostCode = placemark.postalCode!
                    }
                    
                    var subCountry = ""
                    if placemark.country != nil {
                        subCountry = placemark.country!
                    }
                    
                    print("\(subThoroughFare) \(thoroughFare) \n\(subLocality) \n\(subAdminArea) \n\(subPostCode)\n\(subCountry)\n----------\n\n")
                    
                }
            }
        }
    }
    
    internal func setmap(latitude:CLLocationDegrees, longitude:CLLocationDegrees) {
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let coordinates = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
        let region = MKCoordinateRegion(center: coordinates, span:span)
        map.setRegion(region, animated:true)
        var annotation = MKPointAnnotation()
        annotation.title = "That is you"
        annotation.coordinate = coordinates
        map.addAnnotation(annotation)
        
    }


}

